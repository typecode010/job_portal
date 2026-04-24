import csv
from io import BytesIO
from functools import wraps
from pathlib import Path

from django.conf import settings
from django.contrib import messages
from django.contrib.auth.models import User
from django.contrib.auth.decorators import login_required
from django.core.paginator import Paginator
from django.db.models import Count, Q
from django.db.models.functions import TruncMonth
from django.http import FileResponse, HttpResponse
from django.shortcuts import get_object_or_404, redirect, render
from django.urls import reverse
from django.utils import timezone
from reportlab.lib import colors
from reportlab.lib.pagesizes import A4, landscape
from reportlab.lib.styles import getSampleStyleSheet
from reportlab.platypus import Paragraph, SimpleDocTemplate, Spacer, Table, TableStyle

from accounts.models import AccountProfile
from applications.models import JobApplication
from jobs.models import JobPost
from notifications.models import Notification
from notifications.services import create_notification, notify_users

from .forms import FeedbackTicketForm, ReportFilterForm
from .models import AdminActionLog, DatabaseBackup, FeedbackTicket
from .services import create_database_backup, log_admin_action


REPORTS_PAGE_SIZE = 15
FEEDBACK_PAGE_SIZE = 10
BACKUPS_PAGE_SIZE = 10


def admin_required(view_func):
	@wraps(view_func)
	@login_required
	def wrapper(request, *args, **kwargs):
		if not (request.user.is_superuser or request.user.is_staff):
			messages.error(request, 'Admin access is required.')
			return redirect('dashboard:home')
		return view_func(request, *args, **kwargs)

	return wrapper


def get_filtered_applications(filter_form):
	queryset = JobApplication.objects.select_related(
		'job',
		'applicant',
		'applicant__account_profile',
	).order_by('-applied_at')

	if filter_form.is_valid():
		start_date = filter_form.cleaned_data['start_date']
		end_date = filter_form.cleaned_data['end_date']
		status = filter_form.cleaned_data['status']
		role = filter_form.cleaned_data['role']
		job_type = filter_form.cleaned_data['job_type']

		if start_date:
			queryset = queryset.filter(applied_at__date__gte=start_date)
		if end_date:
			queryset = queryset.filter(applied_at__date__lte=end_date)
		if status:
			queryset = queryset.filter(status=status)
		if role:
			queryset = queryset.filter(applicant__account_profile__role=role)
		if job_type:
			queryset = queryset.filter(job__job_type=job_type)

	return queryset


def get_filtered_jobs_for_reports(filter_form):
	queryset = JobPost.objects.select_related('posted_by').order_by('-created_at')

	if filter_form.is_valid():
		start_date = filter_form.cleaned_data['start_date']
		end_date = filter_form.cleaned_data['end_date']
		role = filter_form.cleaned_data['role']
		job_type = filter_form.cleaned_data['job_type']

		if start_date:
			queryset = queryset.filter(created_at__date__gte=start_date)
		if end_date:
			queryset = queryset.filter(created_at__date__lte=end_date)
		if role:
			queryset = queryset.filter(posted_by__account_profile__role=role)
		if job_type:
			queryset = queryset.filter(job_type=job_type)

	return queryset


def get_filtered_account_profiles(filter_form):
	queryset = AccountProfile.objects.select_related('user')

	if filter_form.is_valid():
		start_date = filter_form.cleaned_data['start_date']
		end_date = filter_form.cleaned_data['end_date']
		role = filter_form.cleaned_data['role']

		if start_date:
			queryset = queryset.filter(user__date_joined__date__gte=start_date)
		if end_date:
			queryset = queryset.filter(user__date_joined__date__lte=end_date)
		if role:
			queryset = queryset.filter(role=role)

	return queryset


@login_required
def feedback_home(request):
	feedback_form = FeedbackTicketForm()

	if request.method == 'POST':
		feedback_form = FeedbackTicketForm(request.POST)
		if feedback_form.is_valid():
			feedback_ticket = feedback_form.save(commit=False)
			feedback_ticket.user = request.user
			feedback_ticket.save()

			admin_recipients = User.objects.filter(is_active=True).filter(
				Q(is_staff=True) | Q(is_superuser=True)
			).exclude(id=request.user.id)
			notify_users(
				recipients=admin_recipients,
				title=f'New feedback ticket: {feedback_ticket.subject}',
				message='A new feedback/issue report was submitted and is waiting for admin review.',
				notification_type=Notification.TYPE_SYSTEM,
				actor=request.user,
				action_url='/job_portal/reports/feedback/manage/',
				send_email=False,
			)

			messages.success(request, 'Your feedback has been submitted for admin review.')
			return redirect('reports:feedback')

		messages.error(request, 'Please correct the errors below.')

	tickets_queryset = FeedbackTicket.objects.filter(user=request.user).order_by('-created_at')
	page_obj = Paginator(tickets_queryset, FEEDBACK_PAGE_SIZE).get_page(request.GET.get('page'))

	return render(
		request,
		'reports/feedback.html',
		{
			'feedback_form': feedback_form,
			'page_obj': page_obj,
		},
	)


@admin_required
def feedback_manage(request):
	status_filter = (request.GET.get('status') or '').strip()
	valid_status_values = {choice[0] for choice in FeedbackTicket.STATUS_CHOICES}

	if request.method == 'POST':
		ticket_id = request.POST.get('ticket_id')
		new_status = (request.POST.get('status') or '').strip()
		admin_notes = (request.POST.get('admin_notes') or '').strip()

		if not ticket_id or new_status not in valid_status_values:
			messages.error(request, 'Invalid ticket update request.')
			return redirect('reports:feedback_manage')

		ticket = get_object_or_404(FeedbackTicket.objects.select_related('user'), id=ticket_id)
		previous_status = ticket.status
		ticket.status = new_status
		ticket.admin_notes = admin_notes
		ticket.save(update_fields=['status', 'admin_notes', 'updated_at'])

		log_admin_action(
			admin_user=request.user,
			action_type=AdminActionLog.ACTION_FEEDBACK_STATUS_UPDATED,
			target_type='FeedbackTicket',
			target_id=ticket.id,
			note=(
				f'Status changed from {previous_status} to {ticket.status}. '
				f'Notes: {admin_notes or "(none)"}'
			),
		)

		if previous_status != ticket.status:
			create_notification(
				recipient=ticket.user,
				actor=request.user,
				title=f'Feedback updated: {ticket.subject}',
				message=f'Your feedback ticket is now marked as {ticket.get_status_display()}.',
				notification_type=Notification.TYPE_SYSTEM,
				action_url='/job_portal/reports/feedback/',
				send_email=False,
			)

		messages.success(request, 'Feedback ticket updated successfully.')
		if status_filter and status_filter in valid_status_values:
			return redirect(f"{reverse('reports:feedback_manage')}?status={status_filter}")
		return redirect('reports:feedback_manage')

	tickets_queryset = FeedbackTicket.objects.select_related('user').order_by('-created_at')
	if status_filter:
		if status_filter in valid_status_values:
			tickets_queryset = tickets_queryset.filter(status=status_filter)
		else:
			messages.error(request, 'Invalid status filter. Showing all feedback tickets.')
			return redirect('reports:feedback_manage')

	page_obj = Paginator(tickets_queryset, FEEDBACK_PAGE_SIZE).get_page(request.GET.get('page'))

	return render(
		request,
		'reports/feedback_manage.html',
		{
			'page_obj': page_obj,
			'status_filter': status_filter,
			'status_choices': FeedbackTicket.STATUS_CHOICES,
		},
	)


@admin_required
def backups_home(request):
	if request.method == 'POST':
		result = create_database_backup(created_by=request.user)
		if result.get('success'):
			messages.success(request, result.get('message', 'Backup created successfully.'))
		else:
			messages.error(request, result.get('message', 'Backup creation failed.'))
		return redirect('reports:backups')

	page_obj = Paginator(
		DatabaseBackup.objects.select_related('created_by').order_by('-created_at'),
		BACKUPS_PAGE_SIZE,
	).get_page(request.GET.get('page'))

	return render(
		request,
		'reports/backups.html',
		{
			'page_obj': page_obj,
			'retention_count': int(getattr(settings, 'BACKUP_RETENTION_COUNT', 5) or 0),
		},
	)


@admin_required
def download_backup(request, backup_id):
	backup = get_object_or_404(DatabaseBackup, id=backup_id)
	backup_path = Path(backup.file_path)
	backup_root = Path(getattr(settings, 'BACKUP_ROOT', settings.BASE_DIR / 'backups')).resolve()
	resolved_backup_path = backup_path.resolve()

	if backup_root not in resolved_backup_path.parents and resolved_backup_path != backup_root:
		messages.error(request, 'Invalid backup file path.')
		return redirect('reports:backups')

	if not resolved_backup_path.exists() or not resolved_backup_path.is_file():
		messages.error(request, 'Backup file does not exist on disk.')
		return redirect('reports:backups')

	return FileResponse(
		open(resolved_backup_path, 'rb'),
		as_attachment=True,
		filename=backup.filename,
	)


@admin_required
def reports_home(request):
	filter_form = ReportFilterForm(request.GET or None)
	filtered_applications = get_filtered_applications(filter_form)
	filtered_jobs = get_filtered_jobs_for_reports(filter_form)
	filtered_profiles = get_filtered_account_profiles(filter_form)

	applications_by_status = []
	for status_value, status_label in JobApplication.STATUS_CHOICES:
		applications_by_status.append(
			{
				'label': status_label,
				'count': filtered_applications.filter(status=status_value).count(),
			}
		)

	job_type_display_map = dict(JobPost.JOB_TYPE_CHOICES)
	job_type_breakdown = []
	for row in filtered_jobs.values('job_type').annotate(count=Count('id')).order_by('-count'):
		job_type_value = row['job_type']
		job_type_breakdown.append(
			{
				'label': job_type_display_map.get(job_type_value, job_type_value),
				'count': row['count'],
			}
		)

	role_display_map = dict(AccountProfile.ROLE_CHOICES)
	applicant_role_breakdown = []
	for row in filtered_applications.values('applicant__account_profile__role').annotate(count=Count('id')).order_by('-count'):
		role_value = row['applicant__account_profile__role']
		if role_value:
			applicant_role_breakdown.append(
				{
					'label': role_display_map.get(role_value, role_value),
					'count': row['count'],
				}
			)

	jobs_month_map = {
		item['month']: item['count']
		for item in filtered_jobs.annotate(month=TruncMonth('created_at')).values('month').annotate(count=Count('id')).order_by('month')
	}
	applications_month_map = {
		item['month']: item['count']
		for item in filtered_applications.annotate(month=TruncMonth('applied_at')).values('month').annotate(count=Count('id')).order_by('month')
	}
	month_keys = sorted(set(jobs_month_map.keys()) | set(applications_month_map.keys()))
	monthly_trends = []
	for month_key in month_keys:
		monthly_trends.append(
			{
				'label': month_key.strftime('%b %Y'),
				'jobs_count': jobs_month_map.get(month_key, 0),
				'applications_count': applications_month_map.get(month_key, 0),
			}
		)

	user_activity_summary = {
		'total_accounts': filtered_profiles.count(),
		'active_accounts': filtered_profiles.filter(user__is_active=True).count(),
		'approved_accounts': filtered_profiles.filter(moderation_status=AccountProfile.STATUS_APPROVED).count(),
		'pending_accounts': filtered_profiles.filter(moderation_status=AccountProfile.STATUS_PENDING).count(),
		'rejected_accounts': filtered_profiles.filter(moderation_status=AccountProfile.STATUS_REJECTED).count(),
	}

	page_obj = Paginator(filtered_applications, REPORTS_PAGE_SIZE).get_page(request.GET.get('page'))
	application_rows = []
	for application in page_obj.object_list:
		role_label = 'N/A'
		if hasattr(application.applicant, 'account_profile'):
			role_label = application.applicant.account_profile.get_role_display()

		application_rows.append(
			{
				'application': application,
				'role_label': role_label,
				'job_type_label': application.job.get_job_type_display(),
			}
		)

	query_params = request.GET.copy()
	if 'page' in query_params:
		query_params.pop('page')
	filters_query_string = query_params.urlencode()

	context = {
		'filter_form': filter_form,
		'application_rows': application_rows,
		'page_obj': page_obj,
		'total_filtered': filtered_applications.count(),
		'total_filtered_jobs': filtered_jobs.count(),
		'total_unique_applicants': filtered_applications.values('applicant_id').distinct().count(),
		'applications_by_status': applications_by_status,
		'job_type_breakdown': job_type_breakdown,
		'applicant_role_breakdown': applicant_role_breakdown,
		'monthly_trends': monthly_trends,
		'user_activity_summary': user_activity_summary,
		'filters_query_string': filters_query_string,
	}
	return render(request, 'reports/reports.html', context)


@admin_required
def export_reports_csv(request):
	filter_form = ReportFilterForm(request.GET or None)
	applications = get_filtered_applications(filter_form)

	timestamp = timezone.now().strftime('%Y%m%d_%H%M%S')
	response = HttpResponse(content_type='text/csv')
	response['Content-Disposition'] = f'attachment; filename="applications_report_{timestamp}.csv"'

	writer = csv.writer(response)
	writer.writerow(
		[
			'Application ID',
			'Job Title',
			'Company',
			'Job Type',
			'Applicant Username',
			'Applicant Email',
			'Applicant Role',
			'Status',
			'Applied At',
			'Last Updated',
		]
	)

	for application in applications:
		role_label = 'N/A'
		if hasattr(application.applicant, 'account_profile'):
			role_label = application.applicant.account_profile.get_role_display()

		writer.writerow(
			[
				application.id,
				application.job.title,
				application.job.company_name,
				application.job.get_job_type_display(),
				application.applicant.username,
				application.applicant.email,
				role_label,
				application.get_status_display(),
				application.applied_at.strftime('%Y-%m-%d %H:%M:%S'),
				application.updated_at.strftime('%Y-%m-%d %H:%M:%S'),
			]
		)

	return response


@admin_required
def export_reports_pdf(request):
	filter_form = ReportFilterForm(request.GET or None)
	applications = get_filtered_applications(filter_form)

	timestamp = timezone.now().strftime('%Y%m%d_%H%M%S')
	response = HttpResponse(content_type='application/pdf')
	response['Content-Disposition'] = f'attachment; filename="applications_report_{timestamp}.pdf"'

	buffer = BytesIO()
	document = SimpleDocTemplate(
		buffer,
		pagesize=landscape(A4),
		leftMargin=18,
		rightMargin=18,
		topMargin=24,
		bottomMargin=24,
	)
	styles = getSampleStyleSheet()

	story = [
		Paragraph('Applications Report', styles['Title']),
		Paragraph(
			f'Generated at: {timezone.localtime(timezone.now()).strftime("%Y-%m-%d %H:%M:%S")}',
			styles['Normal'],
		),
		Spacer(1, 12),
	]

	if filter_form.is_valid():
		filters_applied = []
		start_date = filter_form.cleaned_data.get('start_date')
		end_date = filter_form.cleaned_data.get('end_date')
		status = filter_form.cleaned_data.get('status')
		role = filter_form.cleaned_data.get('role')
		job_type = filter_form.cleaned_data.get('job_type')
		status_map = dict(JobApplication.STATUS_CHOICES)
		role_map = dict(AccountProfile.ROLE_CHOICES)
		job_type_map = dict(JobPost.JOB_TYPE_CHOICES)

		if start_date:
			filters_applied.append(f'Start date: {start_date}')
		if end_date:
			filters_applied.append(f'End date: {end_date}')
		if status:
			filters_applied.append(f'Status: {status_map.get(status, status)}')
		if role:
			filters_applied.append(f'Role: {role_map.get(role, role)}')
		if job_type:
			filters_applied.append(f'Job type: {job_type_map.get(job_type, job_type)}')

		if filters_applied:
			story.append(Paragraph('Filters: ' + ' | '.join(filters_applied), styles['Normal']))
			story.append(Spacer(1, 12))

	table_data = [
		['ID', 'Job Title', 'Company', 'Applicant', 'Role', 'Job Type', 'Status', 'Applied At'],
	]

	for application in applications:
		role_label = 'N/A'
		if hasattr(application.applicant, 'account_profile'):
			role_label = application.applicant.account_profile.get_role_display()

		table_data.append(
			[
				str(application.id),
				application.job.title,
				application.job.company_name,
				application.applicant.username,
				role_label,
				application.job.get_job_type_display(),
				application.get_status_display(),
				application.applied_at.strftime('%Y-%m-%d %H:%M'),
			]
		)

	if len(table_data) == 1:
		table_data.append(['-', 'No data found for current filters', '-', '-', '-', '-', '-', '-'])

	table = Table(
		table_data,
		repeatRows=1,
		colWidths=[30, 130, 130, 95, 70, 80, 70, 95],
	)
	table.setStyle(
		TableStyle(
			[
				('BACKGROUND', (0, 0), (-1, 0), colors.HexColor('#0d6efd')),
				('TEXTCOLOR', (0, 0), (-1, 0), colors.white),
				('FONTNAME', (0, 0), (-1, 0), 'Helvetica-Bold'),
				('FONTSIZE', (0, 0), (-1, -1), 9),
				('BACKGROUND', (0, 1), (-1, -1), colors.whitesmoke),
				('GRID', (0, 0), (-1, -1), 0.4, colors.grey),
				('VALIGN', (0, 0), (-1, -1), 'MIDDLE'),
				('ALIGN', (0, 0), (0, -1), 'CENTER'),
			]
		)
	)
	story.append(table)

	document.build(story)
	response.write(buffer.getvalue())
	buffer.close()
	return response

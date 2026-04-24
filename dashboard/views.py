from functools import wraps

from django.contrib.auth.decorators import login_required
from django.contrib.auth.models import User
from django.contrib import messages
from django.core.paginator import Paginator
from django.db.models import Count
from django.db.models import Q
from django.db.models.functions import TruncMonth
from django.shortcuts import get_object_or_404, redirect, render

from accounts.models import AccountProfile
from applications.models import JobApplication
from jobs.forms import JobFilterForm
from jobs.models import JobBookmark, JobPost
from jobs.services import get_suggested_jobs_for_user, normalize_skills, notify_job_seekers_for_new_job
from notifications.models import Notification
from notifications.services import create_notification
from profiles.models import ResumeDocument, UserProfile
from reports.models import AdminActionLog
from reports.services import log_admin_action


def get_user_role(user):
	if user.is_superuser or user.is_staff:
		return 'admin'

	profile = AccountProfile.objects.filter(user=user).first()
	if profile:
		return profile.role

	return 'student'


def role_required(*allowed_roles):
	def decorator(view_func):
		@wraps(view_func)
		@login_required
		def wrapped_view(request, *args, **kwargs):
			role = get_user_role(request.user)
			if role not in allowed_roles:
				return redirect('dashboard:home')
			return view_func(request, *args, **kwargs)

		return wrapped_view

	return decorator


MODERATION_JOBS_PAGE_SIZE = 10
MODERATION_USERS_PAGE_SIZE = 12


@login_required
def dashboard_home(request):
    role = get_user_role(request.user)

    if role == 'alumni':
        return redirect('dashboard:alumni')
    if role == 'employer':
        return redirect('dashboard:employer')
    if role == 'admin':
        return redirect('dashboard:admin_panel')

    return redirect('dashboard:student')


@role_required('student')
def student_dashboard(request):
	applications_queryset = JobApplication.objects.filter(applicant=request.user).select_related('job')
	applications_count = applications_queryset.count()
	bookmarked_job_ids = set(
		JobBookmark.objects.filter(user=request.user).values_list('job_id', flat=True)
	)
	bookmarks_count = len(bookmarked_job_ids)
	unread_notifications_count = Notification.objects.filter(
		recipient=request.user,
		is_read=False,
	).count()
	base_jobs_queryset = JobPost.objects.filter(
		is_active=True,
		approval_status=JobPost.STATUS_APPROVED,
	).select_related('posted_by')
	available_jobs_count = base_jobs_queryset.count()

	status_counts_map = {
		row['status']: row['count']
		for row in applications_queryset.values('status').annotate(count=Count('id'))
	}
	applied_job_ids = set(applications_queryset.values_list('job_id', flat=True))
	applications_by_status = []
	for status_value, status_label in JobApplication.STATUS_CHOICES:
		applications_by_status.append(
			{
				'label': status_label,
				'count': status_counts_map.get(status_value, 0),
			}
		)

	selected_count = status_counts_map.get(JobApplication.STATUS_SELECTED, 0)
	shortlisted_count = status_counts_map.get(JobApplication.STATUS_SHORTLISTED, 0)

	recent_applications = applications_queryset.order_by('-updated_at')[:5]
	recent_notifications = Notification.objects.filter(recipient=request.user).order_by('-created_at')[:5]

	profile = UserProfile.objects.filter(user=request.user).first()
	active_resume_obj = ResumeDocument.objects.filter(user=request.user, is_active=True).first()

	profile_checklist = [
		{
			'label': 'Phone number',
			'completed': bool(profile and str(profile.phone).strip()),
		},
		{
			'label': 'Location',
			'completed': bool(profile and str(profile.location).strip()),
		},
		{
			'label': 'Education summary',
			'completed': bool(profile and str(profile.education_summary).strip()),
		},
		{
			'label': 'Skills',
			'completed': bool(profile and str(profile.skills_text).strip()),
		},
		{
			'label': 'Experience summary',
			'completed': bool(profile and str(profile.experience_summary).strip()),
		},
		{
			'label': 'Active resume',
			'completed': bool(active_resume_obj),
		},
	]
	completed_profile_items = len([item for item in profile_checklist if item['completed']])
	profile_completion = int((completed_profile_items / len(profile_checklist)) * 100)

	filter_form = JobFilterForm(request.GET or None)
	dashboard_jobs_queryset = base_jobs_queryset
	student_filter_active = False

	if filter_form.is_valid():
		query = filter_form.cleaned_data['q'].strip()
		location = filter_form.cleaned_data['location'].strip()
		skills = filter_form.cleaned_data['skills'].strip()
		job_type = filter_form.cleaned_data['job_type'].strip()

		student_filter_active = any([query, location, skills, job_type])

		if query:
			dashboard_jobs_queryset = dashboard_jobs_queryset.filter(
				Q(title__icontains=query)
				| Q(company_name__icontains=query)
				| Q(location__icontains=query)
				| Q(required_skills__icontains=query)
				| Q(description__icontains=query)
			)

		if location:
			dashboard_jobs_queryset = dashboard_jobs_queryset.filter(location__icontains=location)

		if job_type:
			dashboard_jobs_queryset = dashboard_jobs_queryset.filter(job_type=job_type)

		for skill in normalize_skills(skills):
			dashboard_jobs_queryset = dashboard_jobs_queryset.filter(required_skills__icontains=skill)

	dashboard_jobs = list(dashboard_jobs_queryset.order_by('-created_at')[:8])

	suggested_jobs = get_suggested_jobs_for_user(
		request.user,
		queryset=base_jobs_queryset.exclude(id__in=applied_job_ids),
		limit=6,
	)
	new_matches_count = len([item for item in suggested_jobs if item['score'] >= 50])

	return render(
		request,
		'dashboard/student_dashboard.html',
		{
			'applications_count': applications_count,
			'bookmarks_count': bookmarks_count,
			'unread_notifications_count': unread_notifications_count,
			'available_jobs_count': available_jobs_count,
			'profile_completion': profile_completion,
			'new_matches_count': new_matches_count,
			'selected_count': selected_count,
			'shortlisted_count': shortlisted_count,
			'applications_by_status': applications_by_status,
			'recent_applications': recent_applications,
			'recent_notifications': recent_notifications,
			'profile_checklist': profile_checklist,
			'active_resume_obj': active_resume_obj,
			'suggested_jobs': suggested_jobs,
			'student_filter_form': filter_form,
			'student_filter_active': student_filter_active,
			'dashboard_jobs': dashboard_jobs,
			'applied_job_ids': applied_job_ids,
			'bookmarked_job_ids': bookmarked_job_ids,
		},
	)


@role_required('alumni')
def alumni_dashboard(request):
	my_jobs_queryset = JobPost.objects.filter(posted_by=request.user).annotate(
		applications_total=Count('applications')
	).order_by('-updated_at')
	posted_jobs = list(my_jobs_queryset[:12])

	total_posted_jobs = my_jobs_queryset.count()
	approved_posted_jobs = my_jobs_queryset.filter(
		approval_status=JobPost.STATUS_APPROVED,
		is_active=True,
	).count()
	pending_posted_jobs = my_jobs_queryset.filter(
		approval_status=JobPost.STATUS_PENDING,
		is_active=True,
	).count()
	rejected_posted_jobs = my_jobs_queryset.filter(
		approval_status=JobPost.STATUS_REJECTED,
	).count()

	received_applications_queryset = JobApplication.objects.filter(
		job__posted_by=request.user,
	).select_related(
		'job',
		'applicant',
	).order_by('-updated_at')
	received_applications_count = received_applications_queryset.count()
	recent_received_applications = list(received_applications_queryset[:6])

	my_applications_queryset = JobApplication.objects.filter(applicant=request.user)
	my_applications_count = my_applications_queryset.count()
	my_shortlisted_count = my_applications_queryset.filter(
		status=JobApplication.STATUS_SHORTLISTED,
	).count()
	my_selected_count = my_applications_queryset.filter(
		status=JobApplication.STATUS_SELECTED,
	).count()

	unread_notifications_count = Notification.objects.filter(
		recipient=request.user,
		is_read=False,
	).count()
	recent_notifications = Notification.objects.filter(
		recipient=request.user,
	).order_by('-created_at')[:5]

	applied_job_ids = set(my_applications_queryset.values_list('job_id', flat=True))
	bookmarked_job_ids = set(
		JobBookmark.objects.filter(user=request.user).values_list('job_id', flat=True)
	)

	filter_form = JobFilterForm(request.GET or None)
	opportunities_queryset = JobPost.objects.filter(
		is_active=True,
		approval_status=JobPost.STATUS_APPROVED,
	).exclude(
		posted_by=request.user,
	).select_related('posted_by')
	alumni_filter_active = False

	if filter_form.is_valid():
		query = filter_form.cleaned_data['q'].strip()
		location = filter_form.cleaned_data['location'].strip()
		skills = filter_form.cleaned_data['skills'].strip()
		job_type = filter_form.cleaned_data['job_type'].strip()

		alumni_filter_active = any([query, location, skills, job_type])

		if query:
			opportunities_queryset = opportunities_queryset.filter(
				Q(title__icontains=query)
				| Q(company_name__icontains=query)
				| Q(location__icontains=query)
				| Q(required_skills__icontains=query)
				| Q(description__icontains=query)
			)

		if location:
			opportunities_queryset = opportunities_queryset.filter(location__icontains=location)

		if job_type:
			opportunities_queryset = opportunities_queryset.filter(job_type=job_type)

		for skill in normalize_skills(skills):
			opportunities_queryset = opportunities_queryset.filter(required_skills__icontains=skill)

	opportunities = list(opportunities_queryset.order_by('-created_at')[:8])

	suggested_jobs = get_suggested_jobs_for_user(
		request.user,
		queryset=opportunities_queryset.exclude(id__in=applied_job_ids),
		limit=4,
	)

	return render(
		request,
		'dashboard/alumni_dashboard.html',
		{
			'total_posted_jobs': total_posted_jobs,
			'approved_posted_jobs': approved_posted_jobs,
			'pending_posted_jobs': pending_posted_jobs,
			'rejected_posted_jobs': rejected_posted_jobs,
			'received_applications_count': received_applications_count,
			'my_applications_count': my_applications_count,
			'my_shortlisted_count': my_shortlisted_count,
			'my_selected_count': my_selected_count,
			'unread_notifications_count': unread_notifications_count,
			'posted_jobs': posted_jobs,
			'recent_received_applications': recent_received_applications,
			'recent_notifications': recent_notifications,
			'alumni_filter_form': filter_form,
			'alumni_filter_active': alumni_filter_active,
			'opportunities': opportunities,
			'suggested_jobs': suggested_jobs,
			'applied_job_ids': applied_job_ids,
			'bookmarked_job_ids': bookmarked_job_ids,
		},
	)


@role_required('employer')
def employer_dashboard(request):
	return render(request, 'dashboard/employer_dashboard.html')


@role_required('admin')
def admin_panel(request):
	total_users = User.objects.count()
	total_job_posts = JobPost.objects.count()
	total_applications = JobApplication.objects.count()
	active_users = User.objects.filter(is_active=True, is_superuser=False).count()

	applications_by_status = []
	for status_value, status_label in JobApplication.STATUS_CHOICES:
		applications_by_status.append(
			{
				'label': status_label,
				'count': JobApplication.objects.filter(status=status_value).count(),
			}
		)

	pending_jobs = JobPost.objects.filter(
		approval_status=JobPost.STATUS_PENDING,
		is_active=True,
	).count()
	pending_user_approvals = AccountProfile.objects.filter(
		moderation_status=AccountProfile.STATUS_PENDING,
	).count()
	approved_users = AccountProfile.objects.filter(
		moderation_status=AccountProfile.STATUS_APPROVED,
	).count()
	rejected_users = AccountProfile.objects.filter(
		moderation_status=AccountProfile.STATUS_REJECTED,
	).count()
	inactive_users = User.objects.filter(
		is_active=False,
		is_superuser=False,
	).count()

	role_breakdown = []
	for role_value, role_label in AccountProfile.ROLE_CHOICES:
		role_breakdown.append(
			{
				'label': role_label,
				'count': AccountProfile.objects.filter(role=role_value).count(),
			}
		)

	jobs_month_map = {
		item['month']: item['count']
		for item in JobPost.objects.annotate(month=TruncMonth('created_at')).values('month').annotate(count=Count('id')).order_by('month')
	}
	applications_month_map = {
		item['month']: item['count']
		for item in JobApplication.objects.annotate(month=TruncMonth('applied_at')).values('month').annotate(count=Count('id')).order_by('month')
	}
	month_keys = sorted(set(jobs_month_map.keys()) | set(applications_month_map.keys()))[-6:]
	monthly_trends = []
	for month_key in month_keys:
		monthly_trends.append(
			{
				'label': month_key.strftime('%b %Y'),
				'jobs_count': jobs_month_map.get(month_key, 0),
				'applications_count': applications_month_map.get(month_key, 0),
			}
		)

	top_companies = list(
		JobPost.objects.values('company_name').annotate(count=Count('id')).order_by('-count', 'company_name')[:5]
	)

	return render(
		request,
		'dashboard/admin_dashboard.html',
		{
			'total_users': total_users,
			'total_job_posts': total_job_posts,
			'total_applications': total_applications,
			'active_users': active_users,
			'applications_by_status': applications_by_status,
			'pending_jobs': pending_jobs,
			'pending_user_approvals': pending_user_approvals,
			'approved_users': approved_users,
			'rejected_users': rejected_users,
			'inactive_users': inactive_users,
			'role_breakdown': role_breakdown,
			'monthly_trends': monthly_trends,
			'top_companies': top_companies,
		},
	)


@role_required('admin')
def moderation_jobs(request):
	jobs_queryset = JobPost.objects.select_related('posted_by').order_by('-created_at')

	if request.method == 'POST':
		job_id = request.POST.get('job_id')
		action = request.POST.get('action')

		if not job_id or action not in ['approve', 'reject']:
			messages.error(request, 'Invalid moderation action.')
			return redirect('dashboard:moderation_jobs')

		job = get_object_or_404(jobs_queryset, id=job_id)

		if action == 'approve':
			was_not_public = job.approval_status != JobPost.STATUS_APPROVED or not job.is_active

			job.approval_status = JobPost.STATUS_APPROVED
			job.is_active = True
			job.save(update_fields=['approval_status', 'is_active', 'updated_at'])

			if job.posted_by:
				create_notification(
					recipient=job.posted_by,
					actor=request.user,
					title=f'Job approved: {job.title}',
					message='Your job post is approved and now visible to candidates.',
					notification_type=Notification.TYPE_SYSTEM,
					action_url=f'/job_portal/jobs/{job.id}/',
					send_email=True,
				)

			if was_not_public:
				notify_job_seekers_for_new_job(job, request.user)

			log_admin_action(
				admin_user=request.user,
				action_type=AdminActionLog.ACTION_JOB_APPROVED,
				target_type='JobPost',
				target_id=job.id,
				note=f'Approved job: {job.title}',
			)

			messages.success(request, 'Job approved successfully.')

		if action == 'reject':
			job.approval_status = JobPost.STATUS_REJECTED
			job.is_active = False
			job.save(update_fields=['approval_status', 'is_active', 'updated_at'])

			if job.posted_by:
				create_notification(
					recipient=job.posted_by,
					actor=request.user,
					title=f'Job rejected: {job.title}',
					message='Your job post was rejected by admin moderation.',
					notification_type=Notification.TYPE_SYSTEM,
					action_url='/job_portal/jobs/manage/',
					send_email=True,
				)

			log_admin_action(
				admin_user=request.user,
				action_type=AdminActionLog.ACTION_JOB_REJECTED,
				target_type='JobPost',
				target_id=job.id,
				note=f'Rejected job: {job.title}',
			)

			messages.success(request, 'Job rejected successfully.')

		return redirect('dashboard:moderation_jobs')

	jobs_paginator = Paginator(jobs_queryset, MODERATION_JOBS_PAGE_SIZE)
	jobs_page_obj = jobs_paginator.get_page(request.GET.get('page'))

	return render(
		request,
		'dashboard/moderation_jobs.html',
		{
			'jobs': jobs_page_obj.object_list,
			'jobs_page_obj': jobs_page_obj,
		},
	)


@role_required('admin')
def moderation_users(request):
	users_queryset = User.objects.filter(is_superuser=False).order_by('-date_joined')

	if request.method == 'POST':
		user_id = request.POST.get('user_id')
		action = request.POST.get('action')

		if not user_id or action not in ['approve', 'reject', 'pending']:
			messages.error(request, 'Invalid moderation action.')
			return redirect('dashboard:moderation_users')

		user_obj = get_object_or_404(users_queryset, id=user_id)
		profile_obj, _ = AccountProfile.objects.get_or_create(
			user=user_obj,
			defaults={
				'role': AccountProfile.ROLE_STUDENT,
				'moderation_status': AccountProfile.STATUS_PENDING,
				'email_verified': False,
			},
		)

		if action == 'approve':
			user_obj.is_active = profile_obj.email_verified
			user_obj.save(update_fields=['is_active'])
			profile_obj.moderation_status = AccountProfile.STATUS_APPROVED
			profile_obj.save(update_fields=['moderation_status', 'updated_at'])

			approval_message = 'Your account is approved. You can now use all portal features.'
			if not profile_obj.email_verified:
				approval_message = 'Your account is approved by admin. Please verify your email to activate login access.'

			create_notification(
				recipient=user_obj,
				actor=request.user,
				title='Account approved',
				message=approval_message,
				notification_type=Notification.TYPE_SYSTEM,
				action_url='/job_portal/dashboard/',
				send_email=True,
			)

			if profile_obj.email_verified:
				messages.success(request, 'User approved successfully.')
			else:
				messages.success(request, 'User approved, but account remains inactive until email verification.')

			log_admin_action(
				admin_user=request.user,
				action_type=AdminActionLog.ACTION_USER_APPROVED,
				target_type='User',
				target_id=user_obj.id,
				note=f'Approved user: {user_obj.username}',
			)

		if action == 'reject':
			user_obj.is_active = False
			user_obj.save(update_fields=['is_active'])
			profile_obj.moderation_status = AccountProfile.STATUS_REJECTED
			profile_obj.save(update_fields=['moderation_status', 'updated_at'])

			create_notification(
				recipient=user_obj,
				actor=request.user,
				title='Account access disabled',
				message='Your account access was disabled by admin moderation.',
				notification_type=Notification.TYPE_SYSTEM,
				action_url='/job_portal/accounts/login/',
				send_email=True,
			)

			messages.success(request, 'User rejected/disabled successfully.')

			log_admin_action(
				admin_user=request.user,
				action_type=AdminActionLog.ACTION_USER_REJECTED,
				target_type='User',
				target_id=user_obj.id,
				note=f'Rejected user: {user_obj.username}',
			)

		if action == 'pending':
			user_obj.is_active = False
			user_obj.save(update_fields=['is_active'])
			profile_obj.moderation_status = AccountProfile.STATUS_PENDING
			profile_obj.save(update_fields=['moderation_status', 'updated_at'])

			create_notification(
				recipient=user_obj,
				actor=request.user,
				title='Account pending review',
				message='Your account is now pending admin review.',
				notification_type=Notification.TYPE_SYSTEM,
				action_url='/job_portal/accounts/login/',
				send_email=True,
			)

			messages.success(request, 'User set to pending review successfully.')

			log_admin_action(
				admin_user=request.user,
				action_type=AdminActionLog.ACTION_USER_PENDING,
				target_type='User',
				target_id=user_obj.id,
				note=f'Set user pending: {user_obj.username}',
			)

		return redirect('dashboard:moderation_users')

	profile_map = {
		item['user_id']: item
		for item in AccountProfile.objects.filter(user__in=users_queryset).values(
			'user_id',
			'role',
			'moderation_status',
			'email_verified',
		)
	}
	role_display_map = dict(AccountProfile.ROLE_CHOICES)
	moderation_display_map = dict(AccountProfile.MODERATION_STATUS_CHOICES)

	all_rows = []
	for user_obj in users_queryset:
		profile_data = profile_map.get(user_obj.id, {})
		role_value = profile_data.get('role')
		moderation_value = profile_data.get('moderation_status')
		email_verified = bool(profile_data.get('email_verified', False))

		if not moderation_value:
			moderation_value = (
				AccountProfile.STATUS_APPROVED
				if user_obj.is_active
				else AccountProfile.STATUS_PENDING
			)

		all_rows.append(
			{
				'user': user_obj,
				'role_label': role_display_map.get(role_value, 'N/A'),
				'moderation_value': moderation_value,
				'moderation_label': moderation_display_map.get(moderation_value, 'Unknown'),
				'email_verified': email_verified,
			}
		)

	users_paginator = Paginator(all_rows, MODERATION_USERS_PAGE_SIZE)
	users_page_obj = users_paginator.get_page(request.GET.get('page'))
	user_rows = users_page_obj.object_list

	return render(
		request,
		'dashboard/moderation_users.html',
		{
			'user_rows': user_rows,
			'users_page_obj': users_page_obj,
		},
	)

from django.contrib import messages
from django.contrib.auth.decorators import login_required
from django.core.paginator import Paginator
from django.shortcuts import get_object_or_404, redirect, render

from accounts.models import AccountProfile
from notifications.models import Notification
from notifications.services import create_notification

from .models import JobApplication


def get_user_role(user):
    if user.is_superuser or user.is_staff:
        return 'admin'

    profile = AccountProfile.objects.filter(user=user).first()
    if profile:
        return profile.role

    return 'student'


@login_required
def my_applications_view(request):
	role = get_user_role(request.user)
	if role not in ['student', 'alumni']:
		messages.error(request, 'Only student or alumni accounts can view personal applications.')
		return redirect('dashboard:home')

	status_filter = request.GET.get('status', '').strip().lower()
	valid_statuses = {choice[0] for choice in JobApplication.STATUS_CHOICES}

	applications_queryset = JobApplication.objects.filter(applicant=request.user).select_related(
		'job',
		'resume_document',
	).order_by('-updated_at')

	if status_filter in valid_statuses:
		applications_queryset = applications_queryset.filter(status=status_filter)
	else:
		status_filter = ''

	page_obj = Paginator(applications_queryset, 10).get_page(request.GET.get('page'))

	return render(
		request,
		'applications/my_applications.html',
		{
			'applications': page_obj.object_list,
			'page_obj': page_obj,
			'status_filter': status_filter,
			'status_choices': JobApplication.STATUS_CHOICES,
		},
	)


@login_required
def manage_applications_view(request):
	role = get_user_role(request.user)
	if role not in ['alumni', 'employer', 'admin']:
		messages.error(request, 'You are not authorized to manage applications.')
		return redirect('dashboard:home')

	if role == 'admin':
		managed_applications = JobApplication.objects.select_related(
			'job',
			'applicant',
			'resume_document',
		)
	else:
		managed_applications = JobApplication.objects.select_related(
			'job',
			'applicant',
			'resume_document',
		).filter(job__posted_by=request.user)

	if request.method == 'POST':
		app_id = request.POST.get('application_id')
		new_status = request.POST.get('status')
		valid_statuses = {choice[0] for choice in JobApplication.STATUS_CHOICES}

		if not app_id or new_status not in valid_statuses:
			messages.error(request, 'Invalid status update request.')
			return redirect('applications:manage_applications')

		application = get_object_or_404(managed_applications, id=app_id)
		old_status = application.status

		if old_status != new_status:
			application.status = new_status
			application.save(update_fields=['status', 'updated_at'])

			display_status = application.get_status_display()
			create_notification(
				recipient=application.applicant,
				actor=request.user,
				title=f'Application status updated: {application.job.title}',
				message=f'Your application is now marked as {display_status}.',
				notification_type=Notification.TYPE_APPLICATION_STATUS,
				action_url='/job_portal/applications/',
				send_email=True,
			)
			messages.success(request, 'Application status updated.')
		else:
			messages.info(request, 'Status is unchanged.')

		return redirect('applications:manage_applications')

	return render(
		request,
		'applications/manage_applications.html',
		{
			'applications': managed_applications,
			'status_choices': JobApplication.STATUS_CHOICES,
		},
	)

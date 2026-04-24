from django.contrib import messages
from django.contrib.auth.decorators import login_required
from django.core.paginator import Paginator
from django.db.models import Q
from django.shortcuts import get_object_or_404, redirect, render

from accounts.models import AccountProfile
from applications.models import JobApplication
from notifications.models import Notification
from notifications.services import create_notification
from profiles.models import ResumeDocument

from .forms import JobFilterForm, JobPostForm
from .models import JobBookmark, JobPost
from .services import get_suggested_jobs_for_user, normalize_skills


def get_user_role(user):
	if user.is_superuser or user.is_staff:
		return 'admin'

	profile = AccountProfile.objects.filter(user=user).first()
	if profile:
		return profile.role

	return 'student'


def can_manage_jobs(role):
	return role in ['alumni', 'employer', 'admin']


def get_manageable_jobs_queryset(user, role):
	if role == 'admin':
		return JobPost.objects.select_related('posted_by')
	return JobPost.objects.filter(posted_by=user).select_related('posted_by')


def get_public_jobs_queryset():
	return JobPost.objects.filter(
		is_active=True,
		approval_status=JobPost.STATUS_APPROVED,
	).select_related('posted_by')


@login_required
def job_list_view(request):
	role = get_user_role(request.user)
	filter_form = JobFilterForm(request.GET or None)

	base_jobs = get_public_jobs_queryset()
	jobs = base_jobs

	if filter_form.is_valid():
		query = filter_form.cleaned_data['q'].strip()
		location = filter_form.cleaned_data['location'].strip()
		skills = filter_form.cleaned_data['skills'].strip()
		job_type = filter_form.cleaned_data['job_type'].strip()

		if query:
			jobs = jobs.filter(
				Q(title__icontains=query)
				| Q(company_name__icontains=query)
				| Q(location__icontains=query)
				| Q(required_skills__icontains=query)
				| Q(description__icontains=query)
			)

		if location:
			jobs = jobs.filter(location__icontains=location)

		if job_type:
			jobs = jobs.filter(job_type=job_type)

		for skill in normalize_skills(skills):
			jobs = jobs.filter(required_skills__icontains=skill)

	applied_job_ids = set(
		JobApplication.objects.filter(applicant=request.user).values_list('job_id', flat=True)
	)
	bookmarked_job_ids = set(
		JobBookmark.objects.filter(user=request.user).values_list('job_id', flat=True)
	)

	suggested_jobs = []
	if role in ['student', 'alumni']:
		suggested_jobs = get_suggested_jobs_for_user(
			request.user,
			queryset=base_jobs.exclude(id__in=applied_job_ids),
			limit=5,
		)

	return render(
		request,
		'jobs/job_list.html',
		{
			'jobs': jobs,
			'filter_form': filter_form,
			'role': role,
			'applied_job_ids': applied_job_ids,
			'bookmarked_job_ids': bookmarked_job_ids,
			'suggested_jobs': suggested_jobs,
			'can_manage_jobs': can_manage_jobs(role),
		},
	)


@login_required
def job_detail_view(request, job_id):
	job = get_object_or_404(JobPost, id=job_id, is_active=True)
	role = get_user_role(request.user)
	can_manage_job = role == 'admin' or job.posted_by_id == request.user.id

	if job.approval_status != JobPost.STATUS_APPROVED and not can_manage_job:
		messages.info(request, 'This job post is not publicly available.')
		return redirect('jobs:list')

	can_apply = role in ['student', 'alumni'] and job.approval_status == JobPost.STATUS_APPROVED
	can_bookmark = role in ['student', 'alumni'] and job.approval_status == JobPost.STATUS_APPROVED
	already_applied = False
	has_active_resume = False
	is_bookmarked = False

	if can_apply:
		already_applied = JobApplication.objects.filter(job=job, applicant=request.user).exists()
		has_active_resume = ResumeDocument.objects.filter(user=request.user, is_active=True).exists()

	if can_bookmark:
		is_bookmarked = JobBookmark.objects.filter(user=request.user, job=job).exists()

	return render(
		request,
		'jobs/job_detail.html',
		{
			'job': job,
			'role': role,
			'can_apply': can_apply,
			'can_bookmark': can_bookmark,
			'already_applied': already_applied,
			'has_active_resume': has_active_resume,
			'is_bookmarked': is_bookmarked,
			'can_manage_job': can_manage_job,
		},
	)


@login_required
def create_job_view(request):
	role = get_user_role(request.user)
	if not can_manage_jobs(role):
		messages.error(request, 'Only alumni or employer accounts can create jobs.')
		return redirect('dashboard:home')

	if request.method == 'POST':
		form = JobPostForm(request.POST)
		if form.is_valid():
			job = form.save(commit=False)
			job.posted_by = request.user
			job.approval_status = JobPost.STATUS_PENDING
			job.is_active = True
			job.save()

			create_notification(
				recipient=request.user,
				actor=request.user,
				title='Job submitted for approval',
				message='Your job post has been submitted and is waiting for admin approval.',
				notification_type=Notification.TYPE_SYSTEM,
				action_url='/job_portal/jobs/manage/',
				send_email=False,
			)

			messages.success(request, 'Job submitted. It will be visible after admin approval.')
			return redirect('jobs:manage')
	else:
		form = JobPostForm()

	return render(
		request,
		'jobs/job_create.html',
		{
			'form': form,
			'page_title': 'Post a New Job',
			'page_description': 'Create a job opportunity for students and alumni.',
			'submit_label': 'Create Job',
		},
	)


@login_required
def manage_jobs_view(request):
	role = get_user_role(request.user)
	if not can_manage_jobs(role):
		messages.error(request, 'You are not authorized to manage jobs.')
		return redirect('dashboard:home')

	jobs = get_manageable_jobs_queryset(request.user, role)
	return render(
		request,
		'jobs/job_manage.html',
		{
			'jobs': jobs,
			'role': role,
		},
	)


@login_required
def edit_job_view(request, job_id):
	role = get_user_role(request.user)
	if not can_manage_jobs(role):
		messages.error(request, 'You are not authorized to edit jobs.')
		return redirect('dashboard:home')

	job = get_object_or_404(get_manageable_jobs_queryset(request.user, role), id=job_id)

	if request.method == 'POST':
		form = JobPostForm(request.POST, instance=job)
		if form.is_valid():
			updated_job = form.save(commit=False)
			if role != 'admin':
				updated_job.approval_status = JobPost.STATUS_PENDING
			updated_job.save()
			messages.success(request, 'Job updated successfully.')
			if role != 'admin':
				messages.info(request, 'This job is now waiting for admin re-approval.')
			return redirect('jobs:detail', job_id=job.id)
	else:
		form = JobPostForm(instance=job)

	return render(
		request,
		'jobs/job_create.html',
		{
			'form': form,
			'page_title': 'Edit Job',
			'page_description': 'Update the job details for this posting.',
			'submit_label': 'Save Changes',
		},
	)


@login_required
def delete_job_view(request, job_id):
	role = get_user_role(request.user)
	if not can_manage_jobs(role):
		messages.error(request, 'You are not authorized to delete jobs.')
		return redirect('dashboard:home')

	job = get_object_or_404(get_manageable_jobs_queryset(request.user, role), id=job_id)

	if request.method == 'POST':
		if job.is_active:
			job.is_active = False
			job.save(update_fields=['is_active', 'updated_at'])
			messages.success(request, 'Job removed from active listings.')
		else:
			messages.info(request, 'This job is already inactive.')
		return redirect('jobs:manage')

	return redirect('jobs:detail', job_id=job.id)


@login_required
def apply_job_view(request, job_id):
	job = get_object_or_404(
		JobPost,
		id=job_id,
		is_active=True,
		approval_status=JobPost.STATUS_APPROVED,
	)
	role = get_user_role(request.user)

	if role not in ['student', 'alumni']:
		messages.error(request, 'Only student or alumni accounts can apply to jobs.')
		return redirect('jobs:detail', job_id=job.id)

	if request.method != 'POST':
		return redirect('jobs:detail', job_id=job.id)

	if JobApplication.objects.filter(job=job, applicant=request.user).exists():
		messages.warning(request, 'You already applied to this job.')
		return redirect('applications:my_applications')

	active_resume = ResumeDocument.objects.filter(user=request.user, is_active=True).first()
	if active_resume is None:
		messages.info(request, 'Please upload your resume before applying.')
		return redirect('profiles:resume_upload')

	JobApplication.objects.create(
		job=job,
		applicant=request.user,
		cover_letter=request.POST.get('cover_letter', '').strip(),
		resume_document=active_resume,
	)

	if job.posted_by and job.posted_by_id != request.user.id:
		create_notification(
			recipient=job.posted_by,
			actor=request.user,
			title=f'New application received: {job.title}',
			message=f'{request.user.get_full_name() or request.user.username} applied to your job post.',
			notification_type=Notification.TYPE_APPLICATION_SUBMITTED,
			action_url='/job_portal/applications/manage/',
			send_email=True,
		)

	create_notification(
		recipient=request.user,
		actor=request.user,
		title=f'Application submitted: {job.title}',
		message='Your application has been submitted successfully and is now being reviewed.',
		notification_type=Notification.TYPE_APPLICATION_SUBMITTED,
		action_url='/job_portal/applications/',
		send_email=True,
	)

	messages.success(request, 'Application submitted successfully.')
	return redirect('applications:my_applications')


@login_required
def toggle_bookmark_view(request, job_id):
	job = get_object_or_404(
		JobPost,
		id=job_id,
		is_active=True,
		approval_status=JobPost.STATUS_APPROVED,
	)
	role = get_user_role(request.user)

	if role not in ['student', 'alumni']:
		messages.error(request, 'Only student or alumni accounts can bookmark jobs.')
		return redirect('jobs:detail', job_id=job.id)

	if request.method != 'POST':
		return redirect('jobs:detail', job_id=job.id)

	bookmark = JobBookmark.objects.filter(user=request.user, job=job).first()
	if bookmark:
		bookmark.delete()
		messages.info(request, 'Job removed from bookmarks.')
	else:
		JobBookmark.objects.create(user=request.user, job=job)
		messages.success(request, 'Job bookmarked successfully.')

	next_url = request.POST.get('next', '')
	if next_url.startswith('/'):
		return redirect(next_url)

	return redirect('jobs:detail', job_id=job.id)


@login_required
def bookmarked_jobs_view(request):
	role = get_user_role(request.user)
	if role not in ['student', 'alumni']:
		messages.error(request, 'Only student or alumni accounts can view bookmarks.')
		return redirect('dashboard:home')

	bookmarks_queryset = JobBookmark.objects.filter(
		user=request.user,
		job__is_active=True,
		job__approval_status=JobPost.STATUS_APPROVED,
	).select_related('job')
	applied_job_ids = set(
		JobApplication.objects.filter(applicant=request.user).values_list('job_id', flat=True)
	)
	page_obj = Paginator(bookmarks_queryset, 8).get_page(request.GET.get('page'))

	return render(
		request,
		'jobs/bookmarks.html',
		{
			'bookmarks': page_obj.object_list,
			'page_obj': page_obj,
			'applied_job_ids': applied_job_ids,
		},
	)

from django.contrib.auth.models import User
from django.db import models


class JobPost(models.Model):
	JOB_TYPE_FULL_TIME = 'full_time'
	JOB_TYPE_PART_TIME = 'part_time'
	JOB_TYPE_INTERNSHIP = 'internship'
	JOB_TYPE_REMOTE = 'remote'

	STATUS_PENDING = 'pending'
	STATUS_APPROVED = 'approved'
	STATUS_REJECTED = 'rejected'

	JOB_TYPE_CHOICES = [
		(JOB_TYPE_FULL_TIME, 'Full Time'),
		(JOB_TYPE_PART_TIME, 'Part Time'),
		(JOB_TYPE_INTERNSHIP, 'Internship'),
		(JOB_TYPE_REMOTE, 'Remote'),
	]

	APPROVAL_STATUS_CHOICES = [
		(STATUS_PENDING, 'Pending'),
		(STATUS_APPROVED, 'Approved'),
		(STATUS_REJECTED, 'Rejected'),
	]

	posted_by = models.ForeignKey(User, on_delete=models.SET_NULL, null=True, blank=True, related_name='posted_jobs')
	title = models.CharField(max_length=150)
	company_name = models.CharField(max_length=150)
	location = models.CharField(max_length=100, blank=True)
	job_type = models.CharField(max_length=20, choices=JOB_TYPE_CHOICES, default=JOB_TYPE_FULL_TIME)
	required_skills = models.TextField(blank=True)
	description = models.TextField()
	approval_status = models.CharField(max_length=20, choices=APPROVAL_STATUS_CHOICES, default=STATUS_APPROVED)
	is_active = models.BooleanField(default=True)
	created_at = models.DateTimeField(auto_now_add=True)
	updated_at = models.DateTimeField(auto_now=True)

	class Meta:
		ordering = ['-created_at']

	def __str__(self):
		return f'{self.title} - {self.company_name}'


class JobBookmark(models.Model):
	user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='job_bookmarks')
	job = models.ForeignKey(JobPost, on_delete=models.CASCADE, related_name='bookmarks')
	created_at = models.DateTimeField(auto_now_add=True)

	class Meta:
		ordering = ['-created_at']
		unique_together = ('user', 'job')

	def __str__(self):
		return f'{self.user.username} bookmarked {self.job.title}'

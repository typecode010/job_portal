from django.contrib.auth.models import User
from django.db import models


class FeedbackTicket(models.Model):
	STATUS_OPEN = 'open'
	STATUS_IN_PROGRESS = 'in_progress'
	STATUS_RESOLVED = 'resolved'
	STATUS_CLOSED = 'closed'

	STATUS_CHOICES = [
		(STATUS_OPEN, 'Open'),
		(STATUS_IN_PROGRESS, 'In Progress'),
		(STATUS_RESOLVED, 'Resolved'),
		(STATUS_CLOSED, 'Closed'),
	]

	user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='feedback_tickets')
	subject = models.CharField(max_length=150)
	message = models.TextField()
	status = models.CharField(max_length=20, choices=STATUS_CHOICES, default=STATUS_OPEN)
	admin_notes = models.TextField(blank=True)
	created_at = models.DateTimeField(auto_now_add=True)
	updated_at = models.DateTimeField(auto_now=True)

	class Meta:
		ordering = ['-created_at']

	def __str__(self):
		return f'FeedbackTicket({self.id}) {self.subject}'


class DatabaseBackup(models.Model):
	filename = models.CharField(max_length=255, unique=True)
	file_path = models.CharField(max_length=500)
	file_size_bytes = models.BigIntegerField(default=0)
	created_at = models.DateTimeField(auto_now_add=True)
	created_by = models.ForeignKey(
		User,
		on_delete=models.SET_NULL,
		null=True,
		blank=True,
		related_name='database_backups_created',
	)

	class Meta:
		ordering = ['-created_at']

	def __str__(self):
		return self.filename


class AdminActionLog(models.Model):
	ACTION_JOB_APPROVED = 'job_approved'
	ACTION_JOB_REJECTED = 'job_rejected'
	ACTION_USER_APPROVED = 'user_approved'
	ACTION_USER_REJECTED = 'user_rejected'
	ACTION_USER_PENDING = 'user_pending'
	ACTION_FEEDBACK_STATUS_UPDATED = 'feedback_status_updated'
	ACTION_BACKUP_CREATED = 'backup_created'

	ACTION_CHOICES = [
		(ACTION_JOB_APPROVED, 'Job Approved'),
		(ACTION_JOB_REJECTED, 'Job Rejected'),
		(ACTION_USER_APPROVED, 'User Approved'),
		(ACTION_USER_REJECTED, 'User Rejected'),
		(ACTION_USER_PENDING, 'User Pending'),
		(ACTION_FEEDBACK_STATUS_UPDATED, 'Feedback Status Updated'),
		(ACTION_BACKUP_CREATED, 'Backup Created'),
	]

	admin_user = models.ForeignKey(
		User,
		on_delete=models.SET_NULL,
		null=True,
		blank=True,
		related_name='admin_action_logs',
	)
	action_type = models.CharField(max_length=50, choices=ACTION_CHOICES)
	target_type = models.CharField(max_length=100, blank=True)
	target_id = models.CharField(max_length=100, blank=True)
	note = models.TextField(blank=True)
	created_at = models.DateTimeField(auto_now_add=True)

	class Meta:
		ordering = ['-created_at']

	def __str__(self):
		return f'{self.action_type} by {self.admin_user_id or "system"}'

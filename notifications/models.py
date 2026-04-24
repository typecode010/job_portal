from django.contrib.auth.models import User
from django.db import models
from django.utils import timezone


class Notification(models.Model):
	TYPE_NEW_JOB = 'new_job'
	TYPE_APPLICATION_SUBMITTED = 'application_submitted'
	TYPE_APPLICATION_STATUS = 'application_status'
	TYPE_SYSTEM = 'system'

	TYPE_CHOICES = [
		(TYPE_NEW_JOB, 'New Job'),
		(TYPE_APPLICATION_SUBMITTED, 'Application Submitted'),
		(TYPE_APPLICATION_STATUS, 'Application Status Update'),
		(TYPE_SYSTEM, 'System'),
	]

	recipient = models.ForeignKey(User, on_delete=models.CASCADE, related_name='notifications')
	actor = models.ForeignKey(User, on_delete=models.SET_NULL, null=True, blank=True, related_name='triggered_notifications')
	title = models.CharField(max_length=200)
	message = models.TextField()
	notification_type = models.CharField(max_length=40, choices=TYPE_CHOICES, default=TYPE_SYSTEM)
	action_url = models.CharField(max_length=255, blank=True)
	is_read = models.BooleanField(default=False)
	created_at = models.DateTimeField(auto_now_add=True)
	read_at = models.DateTimeField(null=True, blank=True)

	class Meta:
		ordering = ['-created_at']

	def mark_as_read(self):
		if not self.is_read:
			self.is_read = True
			self.read_at = timezone.now()
			self.save(update_fields=['is_read', 'read_at'])

	def __str__(self):
		return f'{self.recipient.username} | {self.title}'


class NotificationPreference(models.Model):
	user = models.OneToOneField(User, on_delete=models.CASCADE, related_name='notification_preference')
	email_notifications_enabled = models.BooleanField(default=True)
	updated_at = models.DateTimeField(auto_now=True)

	def __str__(self):
		return f'NotificationPreference({self.user.username})'

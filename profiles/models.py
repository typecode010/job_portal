from django.db import models
from django.contrib.auth.models import User

from .validators import validate_resume_pdf_file


class UserProfile(models.Model):
	VISIBILITY_PUBLIC = 'public'
	VISIBILITY_PRIVATE = 'private'

	VISIBILITY_CHOICES = [
		(VISIBILITY_PUBLIC, 'Public'),
		(VISIBILITY_PRIVATE, 'Private'),
	]

	user = models.OneToOneField(User, on_delete=models.CASCADE, related_name='user_profile')
	phone = models.CharField(max_length=20, blank=True)
	location = models.CharField(max_length=120, blank=True)
	education_summary = models.TextField(blank=True)
	skills_text = models.TextField(blank=True)
	experience_summary = models.TextField(blank=True)
	visibility = models.CharField(max_length=10, choices=VISIBILITY_CHOICES, default=VISIBILITY_PRIVATE)
	updated_at = models.DateTimeField(auto_now=True)

	def __str__(self):
		return f'Profile - {self.user.username}'


class ResumeDocument(models.Model):
	user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='resume_documents')
	file = models.FileField(upload_to='resumes/', validators=[validate_resume_pdf_file])
	is_active = models.BooleanField(default=True)
	uploaded_at = models.DateTimeField(auto_now_add=True)

	class Meta:
		ordering = ['-uploaded_at']

	def __str__(self):
		return f'Resume - {self.user.username} ({self.uploaded_at:%Y-%m-%d})'

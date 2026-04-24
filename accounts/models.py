from django.db import models
from django.contrib.auth.models import User


class AccountProfile(models.Model):
	ROLE_STUDENT = 'student'
	ROLE_ALUMNI = 'alumni'
	ROLE_EMPLOYER = 'employer'
	STATUS_PENDING = 'pending'
	STATUS_APPROVED = 'approved'
	STATUS_REJECTED = 'rejected'

	ROLE_CHOICES = [
		(ROLE_STUDENT, 'Student'),
		(ROLE_ALUMNI, 'Alumni'),
		(ROLE_EMPLOYER, 'Employer'),
	]

	MODERATION_STATUS_CHOICES = [
		(STATUS_PENDING, 'Pending'),
		(STATUS_APPROVED, 'Approved'),
		(STATUS_REJECTED, 'Rejected'),
	]

	user = models.OneToOneField(User, on_delete=models.CASCADE, related_name='account_profile')
	role = models.CharField(max_length=20, choices=ROLE_CHOICES, default=ROLE_STUDENT)
	moderation_status = models.CharField(
		max_length=20,
		choices=MODERATION_STATUS_CHOICES,
		default=STATUS_APPROVED,
	)
	email_verified = models.BooleanField(default=True)
	created_at = models.DateTimeField(auto_now_add=True)
	updated_at = models.DateTimeField(auto_now=True)

	def __str__(self):
		return f'{self.user.username} - {self.role}'

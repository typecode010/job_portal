from django.contrib.auth.models import User
from django.db import models


class JobApplication(models.Model):
	STATUS_APPLIED = 'applied'
	STATUS_SHORTLISTED = 'shortlisted'
	STATUS_REJECTED = 'rejected'
	STATUS_SELECTED = 'selected'

	STATUS_CHOICES = [
		(STATUS_APPLIED, 'Applied'),
		(STATUS_SHORTLISTED, 'Shortlisted'),
		(STATUS_REJECTED, 'Rejected'),
		(STATUS_SELECTED, 'Selected'),
	]

	job = models.ForeignKey('jobs.JobPost', on_delete=models.CASCADE, related_name='applications')
	applicant = models.ForeignKey(User, on_delete=models.CASCADE, related_name='job_applications')
	resume_document = models.ForeignKey(
		'profiles.ResumeDocument',
		on_delete=models.SET_NULL,
		null=True,
		blank=True,
		related_name='job_applications',
	)
	cover_letter = models.TextField(blank=True)
	status = models.CharField(max_length=20, choices=STATUS_CHOICES, default=STATUS_APPLIED)
	applied_at = models.DateTimeField(auto_now_add=True)
	updated_at = models.DateTimeField(auto_now=True)

	class Meta:
		ordering = ['-applied_at']
		unique_together = ('job', 'applicant')

	def __str__(self):
		return f'{self.applicant.username} - {self.job.title} ({self.status})'

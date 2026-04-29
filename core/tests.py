from django.contrib.auth.models import User
from django.test import TestCase
from django.urls import reverse


class HomePageRoutingTests(TestCase):
	def test_anonymous_user_sees_public_home_page(self):
		response = self.client.get(reverse('home'))

		self.assertEqual(response.status_code, 200)
		self.assertContains(response, 'Register')
		self.assertContains(response, 'Login')
		self.assertNotContains(response, 'Logout')

	def test_authenticated_user_is_redirected_to_dashboard(self):
		user = User.objects.create_user(
			username='home_redirect_user',
			password='testpass123',
			is_active=True,
		)

		self.client.force_login(user)

		response = self.client.get(reverse('home'))

		self.assertEqual(response.status_code, 302)
		self.assertEqual(response.url, '/job_portal/dashboard/')
import tempfile
from pathlib import Path
from subprocess import CompletedProcess
from unittest.mock import patch

from django.contrib.auth.models import User
from django.core.files.uploadedfile import SimpleUploadedFile
from django.test import TestCase, override_settings
from django.urls import reverse

from accounts.models import AccountProfile
from applications.models import JobApplication
from jobs.models import JobPost
from messaging.models import Message, MessageThread
from notifications.models import Notification
from reports.models import AdminActionLog, DatabaseBackup


class EndToEndPortalFlowTests(TestCase):
	def setUp(self):
		self.student = User.objects.create_user(
			username='student_e2e',
			email='student-e2e@example.com',
			password='testpass123',
			is_active=True,
		)
		AccountProfile.objects.create(
			user=self.student,
			role=AccountProfile.ROLE_STUDENT,
			moderation_status=AccountProfile.STATUS_APPROVED,
			email_verified=True,
		)

		self.employer = User.objects.create_user(
			username='employer_e2e',
			email='employer-e2e@example.com',
			password='testpass123',
			is_active=True,
		)
		AccountProfile.objects.create(
			user=self.employer,
			role=AccountProfile.ROLE_EMPLOYER,
			moderation_status=AccountProfile.STATUS_APPROVED,
			email_verified=True,
		)

		self.alumni = User.objects.create_user(
			username='alumni_e2e',
			email='alumni-e2e@example.com',
			password='testpass123',
			is_active=True,
		)
		AccountProfile.objects.create(
			user=self.alumni,
			role=AccountProfile.ROLE_ALUMNI,
			moderation_status=AccountProfile.STATUS_APPROVED,
			email_verified=True,
		)

		self.admin = User.objects.create_user(
			username='admin_e2e',
			email='admin-e2e@example.com',
			password='testpass123',
			is_active=True,
			is_staff=True,
		)

	def test_register_login_profile_apply_status_notification_flow(self):
		response = self.client.post(
			reverse('accounts:register'),
			{
				'username': 'new_student',
				'first_name': 'New',
				'last_name': 'Student',
				'email': 'new-student@example.com',
				'role': AccountProfile.ROLE_STUDENT,
				'password1': 'StrongPass123!',
				'password2': 'StrongPass123!',
			},
			follow=True,
		)
		self.assertEqual(response.status_code, 200)

		registered_user = User.objects.get(username='new_student')
		registered_profile = AccountProfile.objects.get(user=registered_user)
		registered_profile.email_verified = True
		registered_profile.moderation_status = AccountProfile.STATUS_APPROVED
		registered_profile.save(update_fields=['email_verified', 'moderation_status', 'updated_at'])
		registered_user.is_active = True
		registered_user.save(update_fields=['is_active'])

		login_response = self.client.post(
			reverse('accounts:login'),
			{
				'email': 'new-student@example.com',
				'password': 'StrongPass123!',
			},
		)
		self.assertEqual(login_response.status_code, 302)
		self.assertIn('/job_portal/dashboard/', login_response.url)

		profile_response = self.client.post(
			reverse('profiles:profile'),
			{
				'phone': '03001234567',
				'location': 'Karachi',
				'education_summary': 'BS Computer Science',
				'skills_text': 'python,django',
				'experience_summary': 'Internship experience',
				'visibility': 'public',
			},
			follow=True,
		)
		self.assertEqual(profile_response.status_code, 200)

		job = JobPost.objects.create(
			posted_by=self.employer,
			title='Backend Intern',
			company_name='Flow Corp',
			location='Karachi',
			job_type=JobPost.JOB_TYPE_INTERNSHIP,
			required_skills='python,django',
			description='Assist with backend development.',
			approval_status=JobPost.STATUS_APPROVED,
			is_active=True,
		)

		from profiles.models import ResumeDocument

		ResumeDocument.objects.create(
			user=registered_user,
			file=SimpleUploadedFile(
				'resume.pdf',
				b'%PDF-1.4\n%Test resume',
				content_type='application/pdf',
			),
			is_active=True,
		)

		apply_response = self.client.post(
			reverse('jobs:apply', args=[job.id]),
			{
				'cover_letter': 'I am excited to apply.',
			},
			follow=True,
		)
		self.assertEqual(apply_response.status_code, 200)

		application = JobApplication.objects.get(job=job, applicant=registered_user)
		self.assertEqual(application.status, JobApplication.STATUS_APPLIED)

		self.client.force_login(self.employer)
		status_response = self.client.post(
			reverse('applications:manage_applications'),
			{
				'application_id': str(application.id),
				'status': JobApplication.STATUS_SHORTLISTED,
			},
			follow=True,
		)
		self.assertEqual(status_response.status_code, 200)

		application.refresh_from_db()
		self.assertEqual(application.status, JobApplication.STATUS_SHORTLISTED)
		self.assertTrue(
			Notification.objects.filter(
				recipient=registered_user,
				notification_type=Notification.TYPE_APPLICATION_STATUS,
				title__icontains='Application status updated',
			).exists()
		)

	def test_employer_post_job_applicant_apply_messaging_notification_flow(self):
		self.client.force_login(self.employer)
		post_response = self.client.post(
			reverse('jobs:create'),
			{
				'title': 'Junior Django Developer',
				'company_name': 'Talent Labs',
				'location': 'Lahore',
				'job_type': JobPost.JOB_TYPE_FULL_TIME,
				'required_skills': 'python,django,rest',
				'description': 'Work on Django APIs and integrations.',
			},
			follow=True,
		)
		self.assertEqual(post_response.status_code, 200)

		job = JobPost.objects.get(title='Junior Django Developer')
		job.approval_status = JobPost.STATUS_APPROVED
		job.is_active = True
		job.save(update_fields=['approval_status', 'is_active', 'updated_at'])

		from profiles.models import ResumeDocument

		ResumeDocument.objects.create(
			user=self.student,
			file=SimpleUploadedFile(
				'student_resume.pdf',
				b'%PDF-1.4\n%Student resume',
				content_type='application/pdf',
			),
			is_active=True,
		)

		self.client.force_login(self.student)
		apply_response = self.client.post(
			reverse('jobs:apply', args=[job.id]),
			{'cover_letter': 'Please review my profile.'},
			follow=True,
		)
		self.assertEqual(apply_response.status_code, 200)

		application = JobApplication.objects.get(job=job, applicant=self.student)

		open_thread_response = self.client.get(
			reverse('messaging:open_for_application', args=[application.id]),
		)
		self.assertEqual(open_thread_response.status_code, 302)

		thread = MessageThread.objects.get(application=application)
		message_response = self.client.post(
			reverse('messaging:thread_detail', args=[thread.id]),
			{'body': 'I have submitted my application. Thank you.'},
			follow=True,
		)
		self.assertEqual(message_response.status_code, 200)
		self.assertTrue(
			Message.objects.filter(
				thread=thread,
				sender=self.student,
				body='I have submitted my application. Thank you.',
			).exists()
		)
		self.assertTrue(
			Notification.objects.filter(
				recipient=self.employer,
				title__icontains='New message',
			).exists()
		)

	def test_admin_moderation_report_export_backup_and_audit_log_flow(self):
		moderation_target = User.objects.create_user(
			username='pending_user',
			email='pending@example.com',
			password='testpass123',
			is_active=False,
		)
		AccountProfile.objects.create(
			user=moderation_target,
			role=AccountProfile.ROLE_STUDENT,
			moderation_status=AccountProfile.STATUS_PENDING,
			email_verified=True,
		)

		job = JobPost.objects.create(
			posted_by=self.alumni,
			title='Moderation Test Job',
			company_name='Career Hub',
			location='Islamabad',
			job_type=JobPost.JOB_TYPE_PART_TIME,
			required_skills='communication',
			description='Moderation workflow test posting.',
			approval_status=JobPost.STATUS_PENDING,
			is_active=True,
		)

		self.client.force_login(self.admin)

		job_moderation_response = self.client.post(
			reverse('dashboard:moderation_jobs'),
			{
				'job_id': str(job.id),
				'action': 'approve',
			},
			follow=True,
		)
		self.assertEqual(job_moderation_response.status_code, 200)

		user_moderation_response = self.client.post(
			reverse('dashboard:moderation_users'),
			{
				'user_id': str(moderation_target.id),
				'action': 'approve',
			},
			follow=True,
		)
		self.assertEqual(user_moderation_response.status_code, 200)

		csv_response = self.client.get(reverse('reports:export_csv'))
		pdf_response = self.client.get(reverse('reports:export_pdf'))
		self.assertEqual(csv_response.status_code, 200)
		self.assertEqual(pdf_response.status_code, 200)

		with tempfile.TemporaryDirectory() as temp_dir:
			backup_root = Path(temp_dir) / 'backups'

			def fake_run(command, capture_output, text, check):
				result_file_path = Path(command[command.index('--result-file') + 1])
				result_file_path.parent.mkdir(parents=True, exist_ok=True)
				result_file_path.write_text('-- admin flow dump --', encoding='utf-8')
				return CompletedProcess(command, 0, '', '')

			with override_settings(BACKUP_ROOT=backup_root, BACKUP_RETENTION_COUNT=5):
				with patch('reports.services._resolve_mysqldump_executable', return_value='mysqldump'):
					with patch('reports.services.subprocess.run', side_effect=fake_run):
						backup_response = self.client.post(reverse('reports:backups'), follow=True)

		self.assertEqual(backup_response.status_code, 200)
		self.assertEqual(DatabaseBackup.objects.count(), 1)
		self.assertTrue(
			AdminActionLog.objects.filter(action_type=AdminActionLog.ACTION_JOB_APPROVED).exists()
		)
		self.assertTrue(
			AdminActionLog.objects.filter(action_type=AdminActionLog.ACTION_USER_APPROVED).exists()
		)
		self.assertTrue(
			AdminActionLog.objects.filter(action_type=AdminActionLog.ACTION_BACKUP_CREATED).exists()
		)

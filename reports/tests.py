import tempfile
from pathlib import Path
from subprocess import CompletedProcess
from unittest.mock import patch

from django.contrib.auth.models import User
from django.test import TestCase, override_settings
from django.urls import reverse

from accounts.models import AccountProfile
from notifications.models import Notification

from .models import AdminActionLog, DatabaseBackup, FeedbackTicket


class FeedbackTicketFlowTests(TestCase):
	def setUp(self):
		self.student_user = User.objects.create_user(
			username='student_user',
			email='student@example.com',
			password='testpass123',
		)
		self.admin_user = User.objects.create_user(
			username='admin_user',
			email='admin@example.com',
			password='testpass123',
			is_staff=True,
		)

	def test_feedback_submission_requires_login(self):
		response = self.client.get(reverse('reports:feedback'))

		self.assertEqual(response.status_code, 302)
		self.assertIn('/job_portal/accounts/login/', response.url)

	def test_authenticated_user_can_submit_feedback(self):
		self.client.force_login(self.student_user)

		response = self.client.post(
			reverse('reports:feedback'),
			{
				'subject': 'Login issue on dashboard',
				'message': 'I cannot find one of the new dashboard buttons after login.',
			},
			follow=True,
		)

		self.assertEqual(response.status_code, 200)
		self.assertEqual(FeedbackTicket.objects.filter(user=self.student_user).count(), 1)
		self.assertEqual(Notification.objects.filter(recipient=self.admin_user).count(), 1)

	def test_feedback_manage_is_admin_only(self):
		self.client.force_login(self.student_user)
		response = self.client.get(reverse('reports:feedback_manage'))

		self.assertEqual(response.status_code, 302)
		self.assertEqual(response.url, reverse('dashboard:home'))

	def test_admin_can_update_feedback_status(self):
		ticket = FeedbackTicket.objects.create(
			user=self.student_user,
			subject='Need feature clarification',
			message='Please explain how shortlist updates appear in notifications.',
		)

		self.client.force_login(self.admin_user)
		response = self.client.post(
			reverse('reports:feedback_manage'),
			{
				'ticket_id': str(ticket.id),
				'status': FeedbackTicket.STATUS_RESOLVED,
				'admin_notes': 'Explained expected behavior and refreshed your account.',
			},
			follow=True,
		)

		self.assertEqual(response.status_code, 200)

		ticket.refresh_from_db()
		self.assertEqual(ticket.status, FeedbackTicket.STATUS_RESOLVED)
		self.assertEqual(ticket.admin_notes, 'Explained expected behavior and refreshed your account.')
		self.assertTrue(
			Notification.objects.filter(
				recipient=self.student_user,
				title__icontains='Feedback updated',
			).exists()
		)
		self.assertTrue(
			AdminActionLog.objects.filter(
				action_type=AdminActionLog.ACTION_FEEDBACK_STATUS_UPDATED,
				target_type='FeedbackTicket',
				target_id=str(ticket.id),
			).exists()
		)


class BackupUtilityTests(TestCase):
	def setUp(self):
		self.admin_user = User.objects.create_user(
			username='backup_admin',
			email='backup-admin@example.com',
			password='testpass123',
			is_staff=True,
		)
		self.normal_user = User.objects.create_user(
			username='normal_user',
			email='normal@example.com',
			password='testpass123',
		)

	def test_backup_access_control(self):
		self.client.force_login(self.normal_user)
		response = self.client.get(reverse('reports:backups'))

		self.assertEqual(response.status_code, 302)
		self.assertEqual(response.url, reverse('dashboard:home'))

	def test_backup_creation_success(self):
		self.client.force_login(self.admin_user)

		with tempfile.TemporaryDirectory() as temp_dir:
			backup_root = Path(temp_dir) / 'backups'

			def fake_run(command, capture_output, text, check):
				result_file_path = Path(command[command.index('--result-file') + 1])
				result_file_path.parent.mkdir(parents=True, exist_ok=True)
				result_file_path.write_text('-- mock sql dump --', encoding='utf-8')
				return CompletedProcess(command, 0, '', '')

			with override_settings(BACKUP_ROOT=backup_root, BACKUP_RETENTION_COUNT=5):
				with patch('reports.services._resolve_mysqldump_executable', return_value='mysqldump'):
					with patch('reports.services.subprocess.run', side_effect=fake_run):
						response = self.client.post(reverse('reports:backups'), follow=True)

		self.assertEqual(response.status_code, 200)
		self.assertEqual(DatabaseBackup.objects.count(), 1)
		self.assertTrue(
			AdminActionLog.objects.filter(
				action_type=AdminActionLog.ACTION_BACKUP_CREATED,
			).exists()
		)

	def test_backup_creation_failure(self):
		self.client.force_login(self.admin_user)

		with tempfile.TemporaryDirectory() as temp_dir:
			backup_root = Path(temp_dir) / 'backups'
			with override_settings(BACKUP_ROOT=backup_root, BACKUP_RETENTION_COUNT=5):
				with patch('reports.services._resolve_mysqldump_executable', return_value=''):
					response = self.client.post(reverse('reports:backups'), follow=True)

		self.assertEqual(response.status_code, 200)
		self.assertEqual(DatabaseBackup.objects.count(), 0)
		self.assertContains(response, 'mysqldump executable not found')


class AdminAuditLogFlowTests(TestCase):
	def setUp(self):
		self.admin_user = User.objects.create_user(
			username='audit_admin',
			email='audit-admin@example.com',
			password='testpass123',
			is_staff=True,
		)
		self.target_user = User.objects.create_user(
			username='target_user',
			email='target@example.com',
			password='testpass123',
			is_active=False,
		)
		AccountProfile.objects.create(
			user=self.target_user,
			role=AccountProfile.ROLE_STUDENT,
			moderation_status=AccountProfile.STATUS_PENDING,
			email_verified=True,
		)

	def test_user_moderation_creates_audit_log(self):
		self.client.force_login(self.admin_user)
		response = self.client.post(
			reverse('dashboard:moderation_users'),
			{
				'user_id': str(self.target_user.id),
				'action': 'approve',
			},
			follow=True,
		)

		self.assertEqual(response.status_code, 200)
		self.assertTrue(
			AdminActionLog.objects.filter(
				action_type=AdminActionLog.ACTION_USER_APPROVED,
				target_type='User',
				target_id=str(self.target_user.id),
			).exists()
		)

from django.contrib.auth.models import User
from django.test import TestCase
from django.urls import reverse

from applications.models import JobApplication
from jobs.models import JobPost
from notifications.models import Notification

from .models import Message, MessageThread


class MessagingFlowTests(TestCase):
    def setUp(self):
        self.applicant = User.objects.create_user(
            username='applicant',
            email='applicant@example.com',
            password='testpass123',
        )
        self.employer = User.objects.create_user(
            username='employer',
            email='employer@example.com',
            password='testpass123',
        )
        self.outsider = User.objects.create_user(
            username='outsider',
            email='outsider@example.com',
            password='testpass123',
        )
        self.admin_user = User.objects.create_user(
            username='admin_user',
            email='admin@example.com',
            password='testpass123',
            is_staff=True,
        )

        self.job = JobPost.objects.create(
            posted_by=self.employer,
            title='Junior Backend Engineer',
            company_name='Example Corp',
            location='Lahore',
            job_type=JobPost.JOB_TYPE_FULL_TIME,
            required_skills='python,django',
            description='Build APIs and maintain backend modules.',
        )
        self.application = JobApplication.objects.create(
            job=self.job,
            applicant=self.applicant,
            status=JobApplication.STATUS_APPLIED,
        )

    def test_authorized_applicant_can_access_and_send(self):
        self.client.force_login(self.applicant)

        open_response = self.client.get(
            reverse('messaging:open_for_application', args=[self.application.id])
        )
        self.assertEqual(open_response.status_code, 302)

        thread = MessageThread.objects.get(application=self.application)
        detail_response = self.client.get(reverse('messaging:thread_detail', args=[thread.id]))
        self.assertEqual(detail_response.status_code, 200)

        send_response = self.client.post(
            reverse('messaging:thread_detail', args=[thread.id]),
            {'body': 'Hello, I am interested in next steps.'},
            follow=True,
        )
        self.assertEqual(send_response.status_code, 200)
        self.assertTrue(
            Message.objects.filter(
                thread=thread,
                sender=self.applicant,
                body='Hello, I am interested in next steps.',
            ).exists()
        )

    def test_authorized_employer_can_access_and_send(self):
        self.client.force_login(self.employer)

        self.client.get(reverse('messaging:open_for_application', args=[self.application.id]))
        thread = MessageThread.objects.get(application=self.application)

        detail_response = self.client.get(reverse('messaging:thread_detail', args=[thread.id]))
        self.assertEqual(detail_response.status_code, 200)

        send_response = self.client.post(
            reverse('messaging:thread_detail', args=[thread.id]),
            {'body': 'Thanks, please share your availability.'},
            follow=True,
        )
        self.assertEqual(send_response.status_code, 200)
        self.assertTrue(
            Message.objects.filter(
                thread=thread,
                sender=self.employer,
                body='Thanks, please share your availability.',
            ).exists()
        )

    def test_unauthorized_user_is_blocked(self):
        thread = MessageThread.objects.create(application=self.application)
        self.client.force_login(self.outsider)

        detail_response = self.client.get(reverse('messaging:thread_detail', args=[thread.id]))
        self.assertEqual(detail_response.status_code, 302)
        self.assertEqual(detail_response.url, reverse('dashboard:home'))

        open_response = self.client.get(
            reverse('messaging:open_for_application', args=[self.application.id])
        )
        self.assertEqual(open_response.status_code, 302)
        self.assertEqual(open_response.url, reverse('dashboard:home'))

    def test_notification_created_on_send(self):
        self.client.force_login(self.applicant)

        self.client.get(reverse('messaging:open_for_application', args=[self.application.id]))
        thread = MessageThread.objects.get(application=self.application)

        self.client.post(
            reverse('messaging:thread_detail', args=[thread.id]),
            {'body': 'Can we discuss interview timeline?'},
            follow=True,
        )

        self.assertTrue(
            Notification.objects.filter(
                recipient=self.employer,
                actor=self.applicant,
                title__icontains='New message',
            ).exists()
        )

    def test_thread_creation_is_unique_per_application(self):
        self.client.force_login(self.applicant)
        self.client.get(reverse('messaging:open_for_application', args=[self.application.id]))
        self.client.get(reverse('messaging:open_for_application', args=[self.application.id]))

        self.client.force_login(self.employer)
        self.client.get(reverse('messaging:open_for_application', args=[self.application.id]))

        self.assertEqual(MessageThread.objects.filter(application=self.application).count(), 1)

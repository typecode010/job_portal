from django.contrib.auth.models import User
from django.db import models


class MessageThread(models.Model):
    application = models.OneToOneField(
        'applications.JobApplication',
        on_delete=models.CASCADE,
        related_name='message_thread',
    )
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        ordering = ['-updated_at']

    def __str__(self):
        return f'Thread for application {self.application_id}'

    @property
    def applicant(self):
        return self.application.applicant

    @property
    def job_owner(self):
        return self.application.job.posted_by


class Message(models.Model):
    thread = models.ForeignKey(MessageThread, on_delete=models.CASCADE, related_name='messages')
    sender = models.ForeignKey(User, on_delete=models.CASCADE, related_name='sent_messages')
    body = models.TextField(max_length=1000)
    is_read = models.BooleanField(default=False)
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        ordering = ['created_at']

    def __str__(self):
        return f'Message {self.id} in thread {self.thread_id}'

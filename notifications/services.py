from django.conf import settings
from django.core.mail import send_mail
from django.utils import timezone

from .models import Notification, NotificationPreference


def _recipient_allows_email(recipient):
    if not recipient.email:
        return False

    preference, _ = NotificationPreference.objects.get_or_create(user=recipient)
    return preference.email_notifications_enabled


def send_notification_email(recipient, subject, message):
    if not _recipient_allows_email(recipient):
        return False

    send_mail(
        subject=subject,
        message=message,
        from_email=getattr(settings, 'DEFAULT_FROM_EMAIL', 'no-reply@example.com'),
        recipient_list=[recipient.email],
        fail_silently=True,
    )
    return True


def create_notification(
    *,
    recipient,
    title,
    message,
    notification_type=Notification.TYPE_SYSTEM,
    actor=None,
    action_url='',
    send_email=False,
):
    notification = Notification.objects.create(
        recipient=recipient,
        actor=actor,
        title=title,
        message=message,
        notification_type=notification_type,
        action_url=action_url,
    )

    if send_email:
        send_notification_email(recipient, title, message)

    return notification


def notify_users(
    *,
    recipients,
    title,
    message,
    notification_type=Notification.TYPE_SYSTEM,
    actor=None,
    action_url='',
    send_email=False,
):
    notifications = []
    seen_recipient_ids = set()

    for recipient in recipients:
        if recipient.id in seen_recipient_ids:
            continue
        seen_recipient_ids.add(recipient.id)

        notifications.append(
            Notification(
                recipient=recipient,
                actor=actor,
                title=title,
                message=message,
                notification_type=notification_type,
                action_url=action_url,
            )
        )

        if send_email:
            send_notification_email(recipient, title, message)

    if notifications:
        Notification.objects.bulk_create(notifications)

    return len(notifications)


def mark_all_read_for_user(user):
    return Notification.objects.filter(recipient=user, is_read=False).update(
        is_read=True,
        read_at=timezone.now(),
    )

from django.contrib import messages
from django.contrib.auth.decorators import login_required
from django.db.models import Count, Q
from django.shortcuts import get_object_or_404, redirect, render
from django.urls import reverse
from django.utils import timezone

from applications.models import JobApplication
from notifications.models import Notification
from notifications.services import create_notification

from .forms import MessageForm
from .models import Message, MessageThread


def _is_admin(user):
    return user.is_superuser or user.is_staff


def _is_application_participant(user, application):
    return (
        user.id == application.applicant_id
        or (application.job.posted_by_id and user.id == application.job.posted_by_id)
    )


def _is_thread_participant(user, thread):
    return _is_application_participant(user, thread.application)


@login_required
def conversations_list_view(request):
    conversations_queryset = MessageThread.objects.select_related(
        'application',
        'application__job',
        'application__applicant',
        'application__job__posted_by',
    )

    if not _is_admin(request.user):
        conversations_queryset = conversations_queryset.filter(
            Q(application__applicant=request.user)
            | Q(application__job__posted_by=request.user)
        )

    conversations_queryset = conversations_queryset.annotate(
        unread_count=Count(
            'messages',
            filter=Q(messages__is_read=False) & ~Q(messages__sender=request.user),
        )
    ).order_by('-updated_at')

    conversation_rows = []
    for thread in conversations_queryset:
        applicant = thread.application.applicant
        job_owner = thread.application.job.posted_by

        counterpart = None
        if request.user.id == applicant.id:
            counterpart = job_owner
        elif job_owner and request.user.id == job_owner.id:
            counterpart = applicant
        elif _is_admin(request.user):
            counterpart = applicant

        conversation_rows.append(
            {
                'thread': thread,
                'counterpart': counterpart,
                'unread_count': thread.unread_count,
            }
        )

    return render(
        request,
        'messaging/conversations.html',
        {
            'conversation_rows': conversation_rows,
            'is_admin_view': _is_admin(request.user),
        },
    )


@login_required
def open_thread_for_application_view(request, application_id):
    application = get_object_or_404(
        JobApplication.objects.select_related('job', 'job__posted_by', 'applicant'),
        id=application_id,
    )

    if _is_application_participant(request.user, application):
        if not application.job.posted_by:
            messages.error(request, 'This job has no active owner, so messaging is unavailable.')
            return redirect('dashboard:home')

        thread, _ = MessageThread.objects.get_or_create(application=application)
        return redirect('messaging:thread_detail', thread_id=thread.id)

    if _is_admin(request.user):
        thread = MessageThread.objects.filter(application=application).first()
        if not thread:
            messages.info(request, 'No conversation has started for this application yet.')
            return redirect('applications:manage_applications')
        return redirect('messaging:thread_detail', thread_id=thread.id)

    messages.error(request, 'You are not allowed to open this conversation.')
    return redirect('dashboard:home')


@login_required
def thread_detail_view(request, thread_id):
    thread = get_object_or_404(
        MessageThread.objects.select_related(
            'application',
            'application__job',
            'application__applicant',
            'application__job__posted_by',
        ),
        id=thread_id,
    )

    is_participant = _is_thread_participant(request.user, thread)
    is_admin_read_only = _is_admin(request.user) and not is_participant

    if not is_participant and not _is_admin(request.user):
        messages.error(request, 'You are not allowed to view this conversation.')
        return redirect('dashboard:home')

    if is_participant:
        thread.messages.filter(is_read=False).exclude(sender=request.user).update(is_read=True)

    form = MessageForm()
    if request.method == 'POST':
        if not is_participant:
            messages.error(request, 'Only conversation participants can send messages.')
            return redirect('messaging:thread_detail', thread_id=thread.id)

        form = MessageForm(request.POST)
        if form.is_valid():
            message_obj = Message.objects.create(
                thread=thread,
                sender=request.user,
                body=form.cleaned_data['body'],
            )
            MessageThread.objects.filter(id=thread.id).update(updated_at=timezone.now())

            recipient = thread.application.applicant
            if request.user.id == thread.application.applicant_id:
                recipient = thread.application.job.posted_by

            if recipient and recipient.id != request.user.id:
                create_notification(
                    recipient=recipient,
                    actor=request.user,
                    title=f'New message: {thread.application.job.title}',
                    message=(
                        f'{request.user.get_full_name() or request.user.username} sent you a message '
                        f'about your application conversation.'
                    ),
                    notification_type=Notification.TYPE_SYSTEM,
                    action_url=reverse('messaging:thread_detail', kwargs={'thread_id': thread.id}),
                    send_email=False,
                )

            if not message_obj.is_read:
                messages.success(request, 'Message sent.')
            return redirect('messaging:thread_detail', thread_id=thread.id)

    conversation_messages = thread.messages.select_related('sender').order_by('created_at')

    return render(
        request,
        'messaging/thread_detail.html',
        {
            'thread': thread,
            'conversation_messages': conversation_messages,
            'form': form,
            'can_send': is_participant,
            'is_admin_read_only': is_admin_read_only,
        },
    )

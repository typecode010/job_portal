from django.contrib import messages
from django.contrib.auth.decorators import login_required
from django.shortcuts import get_object_or_404, redirect, render

from .models import Notification
from .services import mark_all_read_for_user


@login_required
def notification_center_view(request):
	filter_mode = request.GET.get('filter', 'all').strip().lower()

	notifications = Notification.objects.filter(recipient=request.user)
	if filter_mode == 'unread':
		notifications = notifications.filter(is_read=False)

	unread_count = Notification.objects.filter(recipient=request.user, is_read=False).count()

	return render(
		request,
		'notifications/notification_center.html',
		{
			'notifications': notifications,
			'filter_mode': filter_mode,
			'unread_count': unread_count,
		},
	)


@login_required
def mark_notification_read_view(request, notification_id):
	if request.method != 'POST':
		return redirect('notifications:center')

	notification = get_object_or_404(Notification, id=notification_id, recipient=request.user)
	notification.mark_as_read()

	next_url = request.POST.get('next', '')
	if next_url.startswith('/'):
		return redirect(next_url)

	if notification.action_url.startswith('/'):
		return redirect(notification.action_url)

	return redirect('notifications:center')


@login_required
def mark_all_notifications_read_view(request):
	if request.method != 'POST':
		return redirect('notifications:center')

	marked_count = mark_all_read_for_user(request.user)
	if marked_count:
		messages.success(request, f'{marked_count} notification(s) marked as read.')
	else:
		messages.info(request, 'No unread notifications found.')

	next_url = request.POST.get('next', '')
	if next_url.startswith('/'):
		return redirect(next_url)

	return redirect('notifications:center')

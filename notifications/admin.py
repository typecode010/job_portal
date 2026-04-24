from django.contrib import admin

from .models import Notification, NotificationPreference


@admin.register(Notification)
class NotificationAdmin(admin.ModelAdmin):
	list_display = ('id', 'recipient', 'notification_type', 'title', 'is_read', 'created_at')
	list_filter = ('notification_type', 'is_read', 'created_at')
	search_fields = ('recipient__username', 'recipient__email', 'title', 'message')


@admin.register(NotificationPreference)
class NotificationPreferenceAdmin(admin.ModelAdmin):
	list_display = ('user', 'email_notifications_enabled', 'updated_at')
	list_filter = ('email_notifications_enabled',)
	search_fields = ('user__username', 'user__email')

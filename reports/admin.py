from django.contrib import admin

from .models import AdminActionLog, DatabaseBackup, FeedbackTicket


@admin.register(FeedbackTicket)
class FeedbackTicketAdmin(admin.ModelAdmin):
	list_display = ('id', 'subject', 'user', 'status', 'created_at', 'updated_at')
	list_filter = ('status', 'created_at')
	search_fields = ('subject', 'message', 'user__username', 'user__email')
	readonly_fields = ('created_at', 'updated_at')
	ordering = ('-created_at',)


@admin.register(DatabaseBackup)
class DatabaseBackupAdmin(admin.ModelAdmin):
	list_display = ('id', 'filename', 'file_size_bytes', 'created_by', 'created_at')
	search_fields = ('filename', 'file_path', 'created_by__username', 'created_by__email')
	readonly_fields = ('filename', 'file_path', 'file_size_bytes', 'created_at', 'created_by')
	ordering = ('-created_at',)


@admin.register(AdminActionLog)
class AdminActionLogAdmin(admin.ModelAdmin):
	list_display = ('id', 'action_type', 'admin_user', 'target_type', 'target_id', 'created_at')
	list_filter = ('action_type', 'created_at')
	search_fields = ('target_type', 'target_id', 'note', 'admin_user__username', 'admin_user__email')
	readonly_fields = ('action_type', 'admin_user', 'target_type', 'target_id', 'note', 'created_at')
	ordering = ('-created_at',)

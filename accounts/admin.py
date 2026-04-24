from django.contrib import admin
from .models import AccountProfile


@admin.register(AccountProfile)
class AccountProfileAdmin(admin.ModelAdmin):
	list_display = ('user', 'role', 'moderation_status', 'email_verified', 'created_at')
	list_filter = ('role', 'moderation_status', 'email_verified')
	search_fields = ('user__username', 'user__email')

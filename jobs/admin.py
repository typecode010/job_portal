from django.contrib import admin

from .models import JobBookmark, JobPost


@admin.register(JobPost)
class JobPostAdmin(admin.ModelAdmin):
	list_display = ('id', 'title', 'company_name', 'posted_by', 'approval_status', 'is_active', 'created_at')
	list_filter = ('approval_status', 'is_active', 'job_type', 'created_at')
	search_fields = ('title', 'company_name', 'posted_by__username', 'posted_by__email')


@admin.register(JobBookmark)
class JobBookmarkAdmin(admin.ModelAdmin):
	list_display = ('id', 'user', 'job', 'created_at')
	search_fields = ('user__username', 'user__email', 'job__title')

from django.contrib import admin

from .models import Message, MessageThread


@admin.register(MessageThread)
class MessageThreadAdmin(admin.ModelAdmin):
    list_display = ('id', 'application', 'created_at', 'updated_at')
    search_fields = ('application__job__title', 'application__applicant__username', 'application__job__company_name')
    ordering = ('-updated_at',)


@admin.register(Message)
class MessageAdmin(admin.ModelAdmin):
    list_display = ('id', 'thread', 'sender', 'is_read', 'created_at')
    list_filter = ('is_read', 'created_at')
    search_fields = ('body', 'sender__username', 'thread__application__job__title')
    ordering = ('created_at',)

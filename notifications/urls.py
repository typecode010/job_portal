from django.urls import path

from . import views

app_name = 'notifications'

urlpatterns = [
    path('', views.notification_center_view, name='center'),
    path('mark-all-read/', views.mark_all_notifications_read_view, name='mark_all_read'),
    path('<int:notification_id>/mark-read/', views.mark_notification_read_view, name='mark_read'),
]

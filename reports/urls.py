from django.urls import path

from . import views

app_name = 'reports'

urlpatterns = [
    path('', views.reports_home, name='home'),
    path('feedback/', views.feedback_home, name='feedback'),
    path('feedback/manage/', views.feedback_manage, name='feedback_manage'),
    path('backups/', views.backups_home, name='backups'),
    path('backups/<int:backup_id>/download/', views.download_backup, name='download_backup'),
    path('export/csv/', views.export_reports_csv, name='export_csv'),
    path('export/pdf/', views.export_reports_pdf, name='export_pdf'),
]

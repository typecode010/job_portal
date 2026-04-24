from django.urls import path

from . import views

app_name = 'dashboard'

urlpatterns = [
    path('dashboard/', views.dashboard_home, name='home'),
    path('dashboard/student/', views.student_dashboard, name='student'),
    path('dashboard/alumni/', views.alumni_dashboard, name='alumni'),
    path('dashboard/employer/', views.employer_dashboard, name='employer'),
    path('admin-panel/', views.admin_panel, name='admin_panel'),
    path('admin-panel/moderation/jobs/', views.moderation_jobs, name='moderation_jobs'),
    path('admin-panel/moderation/users/', views.moderation_users, name='moderation_users'),
]

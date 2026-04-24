from django.urls import path

from . import views

app_name = 'jobs'

urlpatterns = [
    path('', views.job_list_view, name='list'),
    path('create/', views.create_job_view, name='create'),
    path('manage/', views.manage_jobs_view, name='manage'),
    path('bookmarks/', views.bookmarked_jobs_view, name='bookmarks'),
    path('<int:job_id>/', views.job_detail_view, name='detail'),
    path('<int:job_id>/edit/', views.edit_job_view, name='edit'),
    path('<int:job_id>/delete/', views.delete_job_view, name='delete'),
    path('<int:job_id>/apply/', views.apply_job_view, name='apply'),
    path('<int:job_id>/bookmark/', views.toggle_bookmark_view, name='toggle_bookmark'),
]

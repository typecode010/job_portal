from django.urls import path

from . import views

app_name = 'profiles'

urlpatterns = [
    path('', views.profile_view, name='profile'),
    path('resume/', views.resume_upload_view, name='resume_upload'),
]

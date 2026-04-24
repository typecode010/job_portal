from django.urls import path

from . import views

app_name = 'applications'

urlpatterns = [
    path('manage/', views.manage_applications_view, name='manage_applications'),
    path('', views.my_applications_view, name='my_applications'),
]

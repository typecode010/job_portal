from django.urls import path

from . import views

app_name = 'messaging'

urlpatterns = [
    path('', views.conversations_list_view, name='list'),
    path('application/<int:application_id>/', views.open_thread_for_application_view, name='open_for_application'),
    path('thread/<int:thread_id>/', views.thread_detail_view, name='thread_detail'),
]

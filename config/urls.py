"""
URL configuration for config project.

The urlpatterns list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/6.0/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.conf import settings
from django.conf.urls.static import static
from django.shortcuts import redirect
from django.urls import include, path


def root_redirect(request):
    return redirect('/job_portal/')

urlpatterns = [
    path('', root_redirect, name='root_redirect'),
    path('job_portal/accounts/', include('accounts.urls')),
    path('job_portal/', include('dashboard.urls')),
    path('job_portal/profile/', include('profiles.urls')),
    path('job_portal/jobs/', include('jobs.urls')),
    path('job_portal/applications/', include('applications.urls')),
    path('job_portal/notifications/', include('notifications.urls')),
    path('job_portal/reports/', include('reports.urls')),
    path('job_portal/messages/', include('messaging.urls')),
    path('job_portal/', include('core.urls')),
    path('job_portal/admin/', admin.site.urls),
]

if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)

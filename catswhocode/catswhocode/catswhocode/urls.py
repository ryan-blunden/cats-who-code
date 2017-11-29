from django.conf import settings
from django.conf.urls import url, include
from django.contrib import admin
from health_check import urls as health_check_urls
from rest_framework.authtoken import views

from cats.api import urls as cats_api_urls

urlpatterns = [
    url(r'^api/v1/auth-token/', views.obtain_auth_token),
    url(r'^api/v1/cats/', include(cats_api_urls)),

    url(r'^health-check/', include(health_check_urls)),

    url(r'^manage/', admin.site.urls),
]

if settings.DEBUG:
    from django.views.static import serve

    urlpatterns.append(
        url(r'^media/(?P<path>.*)$', serve, {'document_root': settings.MEDIA_ROOT})
    )

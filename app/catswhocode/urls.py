from cats.api import urls as cats_api_urls
from django.conf import settings
from django.conf.urls import url, include
from django.contrib import admin
from django.contrib.auth import views as auth_views
from health_check import urls as health_check_urls
from rest_framework.authtoken import views

urlpatterns = [
    url(r'^api/v1/auth-token/', views.obtain_auth_token),
    url(r'^api/v1/cats/', include(cats_api_urls)),

    url(r'^health-check/', include(health_check_urls)),

    url(r'^manage/', admin.site.urls),
    url(r'^manage/password_reset/$', auth_views.password_reset, name='admin_password_reset'),
    url(r'^manage/password_reset/done/$', auth_views.password_reset_done, name='password_reset_done'),
    url(r'^manage/reset/(?P<uidb64>[0-9A-Za-z_\-]+)/(?P<token>.+)/$', auth_views.password_reset_confirm, name='password_reset_confirm'),
    url(r'^manage/reset/done/$', auth_views.password_reset_complete, name='password_reset_complete'),
]

if settings.DEBUG:
    from django.views.static import serve

    urlpatterns.append(
        url(r'^media/(?P<path>.*)$', serve, {'document_root': settings.MEDIA_ROOT})
    )

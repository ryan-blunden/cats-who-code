
from django.conf.urls import url, include
from django.contrib import admin
from rest_framework.authtoken import views

import catswhocode.views
from cats.api import urls as cats_api_urls

urlpatterns = [
    url(r'^api/v1/auth-token/', views.obtain_auth_token),
    # url(r'^api/v1/cats/', include(cats_api_urls)),

    url(r'^health-check/', catswhocode.views.heath_check, name='health-check'),

    url(r'^admin/', admin.site.urls),
]

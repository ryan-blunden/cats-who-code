from django.conf.urls import url

from cats.api.views import CatsList

urlpatterns = [
    url(r'^$', CatsList.as_view(), name='api-closest-stores'),
]

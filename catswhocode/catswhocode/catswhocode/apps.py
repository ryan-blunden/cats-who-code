from django.apps import AppConfig
from django.contrib import admin

class CatsWhoCodeConfig(AppConfig):
    name = 'catswhocode'

    def ready(self):
        admin.site.site_header = 'Cats Who Code'


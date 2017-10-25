from django.contrib import admin

from catswhocode.admin import EnabledModelAdmin
from stores import models


@admin.register(models.Store)
class StoreAdmin(EnabledModelAdmin):
    list_display = ('name', 'address', 'latitude', 'longitude', 'deleted')
    list_filter = ('deleted',)


@admin.register(models.Order)
class OrderAdmin(EnabledModelAdmin):
    list_display = ('store', 'customer', 'order', 'is_complete', 'deleted')
    list_filter = ('date_created', 'is_complete', 'deleted')

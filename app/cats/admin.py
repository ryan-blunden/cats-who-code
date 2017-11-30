from django.contrib import admin

from catswhocode.admin import EnabledModelAdmin
from cats import models


@admin.register(models.Cat)
class CatAdmin(EnabledModelAdmin):
    date_hierarchy = 'date_created'
    list_display = ('member', 'photo', 'caption', 'likes', 'approved', 'deleted')
    list_filter = ('approved', 'deleted')
    search_fields = ('caption', 'attribution')

from django.contrib import admin

from catswhocode.admin import EnabledModelAdmin
from cats import models


@admin.register(models.Cat)
class CatAdmin(EnabledModelAdmin):
    pass
    # list_display = ('user', 'photo', 'caption', 'likes', 'attribution', 'approved', 'deleted')

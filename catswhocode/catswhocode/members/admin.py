from django.contrib import admin

from catswhocode.admin import EnabledModelAdmin
from members import models


@admin.register(models.Member)
class MemberAdmin(EnabledModelAdmin):
    pass

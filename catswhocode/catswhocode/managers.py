from django.db import models


class EnabledManager(models.Manager):
    def get_queryset(self):
        return super(EnabledManager, self).get_queryset().filter(deleted=False)

    def all_and_deleted(self):
        return super(EnabledManager, self).get_queryset().all()

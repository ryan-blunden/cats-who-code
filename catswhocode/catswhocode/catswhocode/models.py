import uuid

from catswhocode.managers import EnabledManager
from django.db import models
from django.utils.timesince import timesince


class BaseModel(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    date_created = models.DateTimeField(auto_now_add=True)
    date_last_updated = models.DateTimeField(auto_now=True)
    deleted = models.BooleanField(default=False)

    objects = EnabledManager()

    class Meta:
        abstract = True
        ordering = ['-date_created']

    @property
    def time_since_create(self):
        return timesince(self.date_created).split(',')[0]

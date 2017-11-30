from django.contrib.auth.base_user import AbstractBaseUser
from django.db import models

from catswhocode.models import BaseModel


class Member(BaseModel):
    username = models.CharField(max_length=100, unique=True)
    name = models.CharField(max_length=100, blank=True)
    email = models.EmailField(max_length=255, unique=True)
    is_active = models.BooleanField(default=True)

    def __str__(self):
        if self.name:
            return self.name
        return self.username

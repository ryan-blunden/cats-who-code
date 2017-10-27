from django.contrib.auth.models import User
from django.db import models

from catswhocode.models import BaseModel


class Cat(BaseModel):
    user = models.OneToOneField(User)
    photo = models.ImageField(upload_to='photos')
    caption = models.CharField(max_length=255)
    likes = models.PositiveSmallIntegerField(default=0)
    attribution = models.CharField(max_length=255)
    approved = models.BooleanField(default=False)

    def __str__(self):
        return self.caption

    class Meta:
        ordering = ['date_created']

    def save(self, force_insert=False, force_update=False, using=None, update_fields=None):
        """ Set the photo name to the id.{EXT} """

        try:
            orig_photo = Cat.objects.get(pk=self.pk)
            if orig_photo.photo != self.photo:
                self.photo.name = '{}.{}'.format(self.photo.id, self.photo.name.split('.')[-1][0:3])
        except Cat.DoesNotExist:
            self.photo.name = '{}.{}'.format(self.photo.id, self.photo.name.split('.')[-1][0:3])

        super(Cat, self).save(force_insert=force_insert, force_update=force_update, using=using,
                              update_fields=update_fields)

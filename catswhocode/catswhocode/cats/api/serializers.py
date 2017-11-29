from django.contrib.auth.models import User
from rest_framework import serializers

from cats.models import Cat
from members.api.serializers import MemberSerializer



class CatSerializer(serializers.ModelSerializer):
    member = MemberSerializer()

    class Meta:
        model = Cat
        fields = ('id', 'member', 'photo', 'caption', 'likes', 'attribution')
        depth = 1

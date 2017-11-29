from rest_framework import serializers

from members.models import Member


class MemberSerializer(serializers.ModelSerializer):
    class Meta:
        model = Member
        fields = ('id', 'username', 'name')

        # def create(self, validated_data):
        #     user = User(
        #         email=validated_data['email'],
        #         username=validated_data['username']
        #     )
        #     user.set_password(validated_data['password'])
        #     user.save()

        #     return user

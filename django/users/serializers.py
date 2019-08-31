from rest_framework import serializers

from . import models


class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.User
        fields = ["id", "username", "name", "facebook_id", "lat", "lon"]


class RequestSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.Request
        fields = ["created_at", "message", "status", "sender", "receiver"]

from friendship.models import FriendshipRequest
from rest_framework import serializers

from . import models


class UserSelfSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.User
        fields = ("id", "username", "fcm_token", "name", "image_url", "fb_id",
                  "first_sign_in"
                  "latitude", "longitude")
        extra_kwargs = {"username": {"required": False}}


class UserPublicSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.User
        fields = ("id", "username", "name", "image_url", "latitude", "fb_id",
                  "longitude")
        read_only_fields = fields


class LobbyExpirationSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.User
        fields = ("lobby_expiration")


class FFRequestReadSerializer(serializers.ModelSerializer):
    sender = UserPublicSerializer()
    receiver = UserPublicSerializer()

    class Meta:
        model = models.FFRequest
        fields = (
            "id",
            "status",
            "created_at",
            "message",
            "sender",
            "receiver",
        )
        read_only_fields = ("status", "sender")


class FFRequestWriteSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.FFRequest
        fields = (
            "id",
            "status",
            "created_at",
            "message",
            "sender",
            "receiver",
        )
        read_only_fields = ("status", "sender")


class FriendshipRequestSerializer(serializers.ModelSerializer):
    class Meta:
        model = FriendshipRequest
        fields = ("from_user", "to_user", "created")

from friendship.models import FriendshipRequest
from rest_framework import serializers

from . import models


class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.User
        fields = [
            "id", "username", "name", "image_url", "latitude", "longitude", "fb_id", "first_sign_in"
        ]


class LobbyExpirationSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.User
        fields = ["lobby_expiration"]


class FFRequestReadSerializer(serializers.ModelSerializer):
    sender = UserSerializer()
    receiver = UserSerializer()

    class Meta:
        model = models.FFRequest
        fields = [
            "id", "status", "created_at", "message", "sender", "receiver",
        ]
        read_only_fields = ["status", "sender"]

class FFRequestWriteSerializer(serializers.ModelSerializer):

    class Meta:
        model = models.FFRequest
        fields = [
            "id", "status", "created_at", "message", "sender", "receiver", 
        ]
        read_only_fields = ["status", "sender"]

class FriendshipRequestSerializer(serializers.ModelSerializer):
    class Meta:
        model = FriendshipRequest
        fields = ["from_user", "to_user", "created"]

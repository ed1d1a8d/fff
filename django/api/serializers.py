from friendship.models import FriendshipRequest
from rest_framework import serializers

from . import models


class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.User
        fields = ["id", "username", "name", "facebook_id", "lat", "lon"]

class LobbyExpirationSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.User
        fields = ["lobby_expiration"]

class RequestSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.Request
        fields = ["id", "created_at", "message", "status", "sender", "receiver"]
        read_only_fields = ["status", "sender"]

"""
class RequestStatusSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.Request
        fields = ["status"]
"""

class FriendshipRequestSerializer(serializers.ModelSerializer):
    class Meta:
        model = FriendshipRequest
        fields = ["from_user", "to_user", "created"]

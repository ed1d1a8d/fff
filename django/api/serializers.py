import friendship
from rest_framework.serializers import ModelSerializer

from . import models


class UserSelfSerializer(ModelSerializer):
    class Meta:
        model = models.User
        fields = ("id", "username", "name", "image_url", "latitude",
                  "longitude", "fb_id", "first_sign_in")
        extra_kwargs = {"username": {"required": False}}


class UserPublicSerializer(ModelSerializer):
    class Meta:
        model = models.User
        fields = ("id", "username", "name", "image_url", "latitude", "fb_id",
                  "longitude")
        read_only_fields = fields


class LobbyExpirationSerializer(ModelSerializer):
    class Meta:
        model = models.User
        fields = ("lobby_expiration",)


class FFRequestReadSerializer(ModelSerializer):
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
            "has_sender_seen_accepted_view",
        )
        read_only_fields = ("status", "sender")


class FFRequestWriteSerializer(ModelSerializer):
    class Meta:
        model = models.FFRequest
        fields = (
            "id",
            "status",
            "created_at",
            "message",
            "sender",
            "receiver",
            "has_sender_seen_accepted_view",
        )
        read_only_fields = ("status", "sender")


class FriendshipRequestSerializer(ModelSerializer):
    from_user = UserPublicSerializer()
    to_user = UserPublicSerializer()

    class Meta:
        model = friendship.models.FriendshipRequest
        fields = ("id", "from_user", "to_user")

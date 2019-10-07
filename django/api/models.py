from datetime import datetime
from enum import Enum

from django.contrib.auth.models import AbstractUser
from django.db import models
from django.utils import timezone


class User(AbstractUser):
    name = models.CharField(blank=True, max_length=255)
    facebook_id = models.CharField(blank=True, max_length=255)

    lon = models.FloatField(null=True, blank=True)
    lat = models.FloatField(null=True, blank=True)

    # Always in utc
    lobby_expiration = models.DateTimeField(default=timezone.now())


class FFRequestStatusEnum(Enum):
    PENDING = "pending"
    ACCEPTED = "accepted"
    REJECTED = "rejected"
    EXPIRED = "expired"  # Due to time
    CANCELLED = "cancelled"


class FFRequest(models.Model):
    """
    A free for _ request model.
    """
    created_at = models.DateTimeField(auto_now_add=True)
    message = models.TextField(max_length=140)

    status = models.CharField(
        blank=False,
        max_length=255,
        choices=[(tag, tag.value) for tag in FFRequestStatusEnum],
    )

    sender = models.ForeignKey(User,
                               related_name="request_sender_set",
                               on_delete=models.CASCADE)
    receiver = models.ForeignKey(User,
                                 related_name="request_receiver_set",
                                 on_delete=models.CASCADE)
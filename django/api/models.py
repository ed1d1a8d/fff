from datetime import datetime, timezone
from enum import Enum

from django.contrib.auth.models import AbstractUser
from django.db import models
from django.utils.translation import ugettext_lazy as _
import fcm_django.models


class User(AbstractUser):
    name = models.CharField(max_length=255, blank=True)
    image_url = models.URLField(max_length=2048, blank=True)

    longitude = models.FloatField(null=True, blank=True)
    latitude = models.FloatField(null=True, blank=True)

    # Always in utc
    # TODO: Rename to online_until
    lobby_expiration = models.DateTimeField(
        default=datetime.fromtimestamp(0, tz=timezone.utc))

    fb_id = models.CharField(max_length=255, blank=True)

    first_sign_in = models.BooleanField(default=True)


class Device(fcm_django.models.AbstractFCMDevice):
    """Makes registration_id unique and type optional."""
    registration_id = models.TextField(unique=True)
    type = models.CharField(max_length=10, null=True, blank=True)

    class Meta:
        verbose_name = "Device"


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
    )

    sender = models.ForeignKey(User,
                               related_name="request_sender_set",
                               on_delete=models.CASCADE)
    receiver = models.ForeignKey(User,
                                 related_name="request_receiver_set",
                                 on_delete=models.CASCADE)

    def __str__(self):
        return f"{self.message} {self.sender} {self.receiver} {self.status}"

    class Meta:
        verbose_name = "FFRequest"

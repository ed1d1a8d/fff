from datetime import datetime

from django.contrib.auth.models import AbstractUser
from django.db import models


class User(AbstractUser):
    name = models.CharField(blank=True, max_length=255)
    facebook_id = models.CharField(blank=True, max_length=255)

    lon = models.FloatField(null=True, blank=True)
    lat = models.FloatField(null=True, blank=True)

    # Always in utc
    lobby_expiration = models.DateTimeField(default=datetime.utcnow())


class Request(models.Model):
    created_at = models.DateTimeField(auto_now_add=True)
    message = models.TextField(max_length=140)

    # Pending, Accepted, Rejected, Expired, Cancelled
    status = models.CharField(blank=False, max_length=255)

    sender = models.ForeignKey(User,
                               related_name="request_sender_set",
                               on_delete=models.CASCADE)
    receiver = models.ForeignKey(User,
                                 related_name="request_receiver_set",
                                 on_delete=models.CASCADE)

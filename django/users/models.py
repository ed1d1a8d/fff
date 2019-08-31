from datetime import datetime

from django.contrib.auth.models import AbstractUser
from django.db import models


class User(AbstractUser):
    name = models.CharField(blank=True, max_length=255)
    facebook_id = models.CharField(blank=True, max_length=255)

    lon = models.FloatField(null=True, blank=True)
    lat = models.FloatField(null=True, blank=True)

    # How long user will remain "online"
    # Always in utc
    # online_until = models.DateTimeField(default=datetime.utcnow())

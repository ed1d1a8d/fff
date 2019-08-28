from django.contrib.auth.models import AbstractUser
from django.db import models


class User(AbstractUser):
    name = models.CharField(blank=True, max_length=255)

    lon = models.FloatField(null=True, blank=True)
    lat = models.FloatField(null=True, blank=True)


class Friendship(models.Model):
    """
    Model for friendships.

    Friendships are directed.
    A one way friendship indicates a "friend request".
    """
    created = models.DateTimeField(auto_now_add=True, editable=False)
    src = models.ForeignKey(User,
                            on_delete=models.CASCADE,
                            related_name="src_set")
    dst = models.ForeignKey(User,
                            on_delete=models.CASCADE,
                            related_name="dst_set")

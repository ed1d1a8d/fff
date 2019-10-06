from django import forms
from django.contrib import auth
from . import models


class UserCreationForm(auth.forms.UserCreationForm):
    class Meta(auth.forms.UserCreationForm):
        model = models.User
        fields = ("username", "name", "facebook_id")


class UserChangeForm(auth.forms.UserChangeForm):
    class Meta(auth.forms.UserChangeForm):
        model = models.User
        fields = ("username", "name", "facebook_id")

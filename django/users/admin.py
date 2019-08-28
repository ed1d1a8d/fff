from django.contrib import admin
from django.contrib import auth

from . import forms
from . import models


class UserAdmin(auth.admin.UserAdmin):
    add_form = forms.UserCreationForm
    form = forms.UserChangeForm
    model = models.User
    list_display = ['email', 'username', 'name']


admin.site.register(models.User, UserAdmin)

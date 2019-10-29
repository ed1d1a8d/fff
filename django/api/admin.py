from django.contrib import admin
from django.contrib import auth

from . import models


class UserCreationForm(auth.forms.UserCreationForm):
    class Meta(auth.forms.UserCreationForm):
        model = models.User
        fields = "__all__"


class UserChangeForm(auth.forms.UserChangeForm):
    class Meta(auth.forms.UserChangeForm):
        model = models.User
        fields = "__all__"


@admin.register(models.User)
class UserAdmin(auth.admin.UserAdmin):
    add_form = UserCreationForm
    form = UserChangeForm

    fieldsets = auth.admin.UserAdmin.fieldsets + (("FFF Fields", {
        "fields": ("longitude", "latitude", "name")
    }), )

    list_display = ("username", "name")


admin.site.register(models.Device)
admin.site.register(models.FFRequest)

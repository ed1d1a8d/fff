from django.contrib import auth
from .models import User


class UserCreationForm(auth.forms.UserCreationForm):
    class Meta:
        model = User
        fields = ('username', 'email')


class UserChangeForm(auth.forms.UserChangeForm):
    class Meta:
        model = User
        fields = auth.forms.UserChangeForm.Meta.fields

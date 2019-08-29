from django.core import HttpRequest
from friendship.models import Friend
from rest_framework import generics
from rest_framework import permissions

from .models import User
from .serializers import UserSerializer


class SelfDetail(generics.RetrieveUpdateAPIView):
    serializer_class = UserSerializer

    def get_object(self):
        return self.request.user


class FriendList(generics.ListAPIView):
    serializer_class = UserSerializer

    def get_queryset(self):
        return Friend.objects.friends(self.request.user)


def dumb(request):
    return HttpRequest("you dumb asf")


# TODO: Friend request system

# class FriendDetail(generics.RetrieveAPIView):
#    serializer_class = UserSerializer
#
#    def get_queryset(self):
#        return Friend.objects.friends(self.request.user)

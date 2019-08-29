from friendship.models import Friend
from rest_framework import generics
from rest_framework import permissions

from .models import User
from .serializers import UserSerializer


class SelfDetail(generics.RetrieveUpdateAPIView):
    permission_classes = [permissions.IsAuthenticated]
    serializer_class = UserSerializer
    def get_object(self):
        return self.request.user


class FriendList(generics.ListAPIView):
    permission_classes = [permissions.IsAuthenticated]
    serializer_class = UserSerializer

    def get_queryset(self):
        return Friend.objects.friends(self.request.user)


class FriendDetail(generics.RetrieveAPIView):
    permission_classes = [permissions.IsAuthenticated]
    serializer_class = UserSerializer

    def get_queryset(self):
        return Friend.objects.friends(self.request.user)

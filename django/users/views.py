from django.http import HttpRequest
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


# details about a specific user who is a friend
class FriendDetail(generics.RetrieveAPIView):
   serializer_class = UserSerializer

   def get_object(self):
       pk = self.kwargs["pk"]
       other = User.objects.get(pk=pk)
       print("pk", pk)
       if Friend.objects.are_friends(self.request.user, other) != True:
           return other # should be an error
       return other

from rest_framework import generics
from django.http import HttpResponse
from rest_framework import permissions

from . import models
from . import serializers


class UserListView(generics.ListCreateAPIView):
    queryset = models.User.objects.all()
    serializer_class = serializers.UserSerializer

#class UserDetail(generics.RetrieveAPIView):
#    permissions_classes = [permissions.IsAuthenticated]
#    queryset = models.User.objects.all()
#    serializer_class = serializers.UserSerializer


#class UserFriendsView(generics.ListCreateAPIView):
#    incoming = models.Friendship.objects.filter(dst=self.user).values_list("src",
#                                                                    flat=True)
#    outgoing = models.Friendship.objects.filter(src=self.user).values_list("dst",
#                                                                    flat=True)

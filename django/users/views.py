from django.http import HttpResponse, JsonResponse
from rest_framework import generics
from rest_framework import permissions

from friendship.models import Friend
from friendship.models import FriendshipRequest

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


# friend requests
class FriendsRequests(generics.GenericAPIView):
    # return a response depending on the action passed in
    def get(self, request, action):
        if action == "unrejected":
            try:
                pending = Friend.objects.unrejected_requests(user=request.user)
                serializer = UserSerializer(pending, many=True)
                return JsonResponse(serializer.data, safe=False)
            except Exception as exception:
                return HttpResponse(str(exception), status=400)
        elif action == "unread":
            try:
                unread = Friend.objects.unread_requests(user=request.user)
                serializer = UserSerializer(unread, many=True)
                return JsonResponse(serializer.data, safe=False)
            except Exception as exception:
                return HttpResponse(str(exception), status=400)
        return HttpResponse("Invalid action.", status=400)


class FriendsActions(generics.GenericAPIView):
    # return a response depending on the action passed in
    def get(self, request, action, pk):
        try:
            other_user = User.objects.get(pk=pk)
        except:
            return HttpResponse("User pk does not exist.", status=400)

        if action == "info":
            if Friend.objects.are_friends(request.user, other_user) != True:
                return HttpResponse("Target user is not a friend.", status=400)
            serializer = UserSerializer([other_user], many=True)
            return JsonResponse(serializer.data, safe=False)
        elif action == "request":
            try:
                Friend.objects.add_friend(request.user, other_user)
                return HttpResponse("Sent friendship request to pk " +
                                    other_user.id + ".")
            except Exception as exception:
                return HttpResponse(str(exception), status=400)
        elif action == "accept":
            try:
                friend_request = FriendshipRequest.objects.get(
                    to_user=request.user.id, from_user=pk)
                friend_request.accept()
                return HttpResponse("Accepted friendship request from " + pk +
                                    ".")
            except Exception as exception:
                return HttpResponse(str(exception), status=400)
        elif action == "decline":
            try:
                friend_request = FriendshipRequest.objects.get(
                    to_user=request.user.id, from_user=pk)
                friend_request.decline()
                return HttpResponse("Declined friendship request from " + pk +
                                    ".")
            except Exception as exception:
                return HttpResponse(str(exception), status=400)
        elif action == "remove":
            try:
                Friend.objects.remove_friend(request.user, other_user)
                return HttpResponse("Removed friend " + pk + ".")
            except Exception as exception:
                return HttpResponse(str(exception), status=400)

        return HttpResponse("Invalid action.", status=400)

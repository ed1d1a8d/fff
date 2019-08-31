from django.db import transaction
from django.db.models import Q
from django.http import HttpResponse, JsonResponse
from django.utils import timezone
from rest_framework import generics
from rest_framework import permissions
from rest_framework import status
from rest_framework.response import Response

from friendship.models import Friend
from friendship.models import FriendshipRequest

from .models import StatusEnum, Request, User
from .serializers import (
    LobbyExpirationSerializer,
    RequestSerializer,
    UserSerializer,
    FriendshipRequestSerializer,
)


class SelfDetail(generics.RetrieveUpdateAPIView):
    serializer_class = UserSerializer

    def get_object(self):
        return self.request.user


class LobbyExpiration(generics.GenericAPIView):
    def get(self, request):
        serializer = LobbyExpirationSerializer(request.user)
        return JsonResponse(serializer.data, safe=False)

    def post(self, request):
        """
        body_unicode = request.body.decode('utf-8')
        body = json.loads(body_unicode)
        new_lobby_expiration = body["lobby_expiration"]
        """

        serializer = LobbyExpirationSerializer(data=request.data)
        if not serializer.is_valid():
            return Response(serializer.errors,
                            status=status.HTTP_400_BAD_REQUEST)

        new_lobby_expiration = serializer.validated_data["lobby_expiration"]

        with transaction.atomic():
            if min(request.user.lobby_expiration,
                   new_lobby_expiration) < timezone.now():
                Request.objects.filter(status=StatusEnum.PENDING.value,
                                       sender=request.user).update(
                                           status=StatusEnum.EXPIRED.value)

            request.user.lobby_expiration = new_lobby_expiration
            request.user.save()

        return HttpResponse(status=200)


class CreateRequest(generics.CreateAPIView):
    serializer_class = RequestSerializer

    def perform_create(self, serializer):
        serializer.save(
            status=StatusEnum.PENDING.value,
            sender=self.request.user,
        )

    def create(self, request, *args, **kwargs):
        serializer = RequestSerializer(data=request.data)
        if not serializer.is_valid():
            return Response(serializer.errors,
                            status=status.HTTP_400_BAD_REQUEST)
        receiver = serializer.validated_data["receiver"]
        if Friend.objects.are_friends(
                request.user, User.objects.get(pk=receiver.id)) != True:
            return HttpResponse(f"Can't send request to non-friends",
                                status=400)

        return super().create(request, *args, **kwargs)


"""
# TODO: Restrict to only accept/reject
class RespondToRequest(generics.UpdateAPIView):
    serializer_class = RequestStatusSerializer

    def get_queryset(self):
        return Request.objects.filter(
            status=StatusEnum.PENDING.value,
            receiver=self.request.user,
        )
"""


class RespondToRequest(generics.GenericAPIView):
    def post(self, request, pk, action):  # TODO: Redo status codes
        try:
            req = Request.objects.get(pk=pk)
        except:
            return HttpResponse(f"Request {pk} does not exist", status=400)

        if req.status != StatusEnum.PENDING.value:
            return HttpResponse("Can't act on non-PENDING request", status=400)

        if action == StatusEnum.ACCEPTED.value:
            with transaction.atomic():
                req.status = action
                req.save()

                Request.objects.filter(status=StatusEnum.PENDING.value,
                                       sender=request.user).update(
                                           status=StatusEnum.CANCELLED.value)
                Request.objects.filter(status=StatusEnum.PENDING.value,
                                       receiver=request.user).update(
                                           status=StatusEnum.REJECTED.value)
            return HttpResponse(status=200)
        elif action == StatusEnum.REJECTED.value:
            #Request.objects.filter(pk=pk).update(status=action)
            req.status = action
            req.save()
            return HttpResponse(status=200)
        else:
            return HttpResponse(f"Invalid action: {action}", status=400)


class IncomingRequests(generics.ListAPIView):
    serializer_class = RequestSerializer

    def get_queryset(self):
        return Request.objects.filter(
            status=self.kwargs["status"],
            receiver=self.request.user,
        )


class OutgoingRequests(generics.ListAPIView):
    serializer_class = RequestSerializer

    def get_queryset(self):
        return Request.objects.filter(
            status=self.kwargs["status"],
            sender=self.request.user,
        )


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
                serializer = FriendshipRequestSerializer(pending, many=True)
                return JsonResponse(serializer.data, safe=False)
            except Exception as exception:
                return HttpResponse(str(exception), status=400)
        elif action == "unread":
            try:
                unread = Friend.objects.unread_requests(user=request.user)
                serializer = FriendshipRequestSerializer(unread, many=True)
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
                return HttpResponse("Accepted friendship request from " +
                                    str(pk) + ".")
            except Exception as exception:
                return HttpResponse(str(exception), status=400)
        elif action == "decline":
            try:
                friend_request = FriendshipRequest.objects.get(
                    to_user=request.user.id, from_user=pk)
                friend_request.decline()
                return HttpResponse("Declined friendship request from " +
                                    str(pk) + ".")
            except Exception as exception:
                return HttpResponse(str(exception), status=400)
        elif action == "remove":
            try:
                Friend.objects.remove_friend(request.user, other_user)
                return HttpResponse("Removed friend " + str(pk) + ".")
            except Exception as exception:
                return HttpResponse(str(exception), status=400)

        return HttpResponse("Invalid action.", status=400)

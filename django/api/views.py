from django.db import transaction
from django.db.models import Q
from django.http import HttpResponse, JsonResponse
from django.utils import timezone
import rest_framework.generics
from rest_framework.response import Response

from friendship.models import Friend
from friendship.models import FriendshipRequest

from .models import FFRequest, FFRequestStatusEnum, User
from .serializers import (
    LobbyExpirationSerializer,
    FFRequestSerializer,
    UserSerializer,
    FriendshipRequestSerializer,
)


class SelfDetail(rest_framework.generics.RetrieveUpdateAPIView):
    serializer_class = UserSerializer

    def get_object(self):
        return self.request.user


class LobbyExpiration(rest_framework.generics.GenericAPIView):
    def get(self, request):
        serializer = LobbyExpirationSerializer(request.user)
        return JsonResponse(serializer.data, safe=False)

    def post(self, request):
        serializer = LobbyExpirationSerializer(data=request.data)
        if not serializer.is_valid():
            return Response(serializer.errors,
                            status=rest_framework.status.HTTP_400_BAD_REQUEST)

        new_lobby_expiration = serializer.validated_data["lobby_expiration"]

        with transaction.atomic():
            if min(request.user.lobby_expiration,
                   new_lobby_expiration) < timezone.now():
                print(f"Deleting expired requests for {request.user}..."
                      )  # TODO: Replace with better logging.
                FFRequest.objects.filter(
                    status=FFRequestStatusEnum.PENDING.value,
                    sender=request.user).update(
                        status=FFRequestStatusEnum.EXPIRED.value)

            request.user.lobby_expiration = new_lobby_expiration
            request.user.save()

        return HttpResponse(status=200)


class LobbyFriends(rest_framework.generics.ListAPIView):
    serializer_class = UserSerializer

    def get_queryset(self):
        return [
            f.from_user
            for f in Friend.objects.select_related("from_user").filter(
                to_user=self.request.user,
                from_user__lobby_expiration__gt=timezone.now()).all()
        ]


class CreateFFRequest(rest_framework.generics.CreateAPIView):
    serializer_class = FFRequestSerializer

    def perform_create(self, serializer):
        serializer.save(
            status=FFRequestStatusEnum.PENDING.value,
            sender=self.request.user,
        )

    def create(self, request, *args, **kwargs):
        serializer = FFRequestSerializer(data=request.data)
        if not serializer.is_valid():
            return Response(serializer.errors,
                            status=rest_framework.status.HTTP_400_BAD_REQUEST)
        receiver = serializer.validated_data["receiver"]
        if Friend.objects.are_friends(
                request.user, User.objects.get(pk=receiver.id)) != True:
            return HttpResponse(f"Can't send request to non-friends",
                                status=400)

        return super().create(request, *args, **kwargs)


class RespondToFFRequest(rest_framework.generics.GenericAPIView):
    def post(self, request, pk, action):  # TODO: Redo status codes
        try:
            req = Request.objects.get(pk=pk)
        except:
            return HttpResponse(f"Request {pk} does not exist", status=400)

        if req.status != FFRequestStatusEnum.PENDING.value:
            return HttpResponse("Can't act on non-PENDING request", status=400)

        if action == FFRequestStatusEnum.ACCEPTED.value:
            with transaction.atomic():
                req.status = action
                req.save()

                FFRequest.objects.filter(
                    status=FFRequestStatusEnum.PENDING.value,
                    sender=request.user).update(
                        status=FFRequestStatusEnum.CANCELLED.value)
                FFRequest.objects.filter(
                    status=FFRequestStatusEnum.PENDING.value,
                    receiver=request.user).update(
                        status=FFRequestStatusEnum.REJECTED.value)
            return HttpResponse(status=200)
        elif action == FFRequestStatusEnum.REJECTED.value:
            req.status = action
            req.save()
            return HttpResponse(status=200)
        else:
            return HttpResponse(f"Invalid action: {action}", status=400)


class IncomingFFRequests(rest_framework.generics.ListAPIView):
    # TODO: Filter to non-expired requests.
    serializer_class = FFRequestSerializer

    def get_queryset(self):
        return FFRequest.objects.filter(
            status=self.kwargs["status"],
            receiver=self.request.user,
        )


class OutgoingFFRequests(rest_framework.generics.ListAPIView):
    # TODO: Filter to non-expired requests.
    serializer_class = FFRequestSerializer

    def get_queryset(self):
        return FFRequest.objects.filter(
            status=self.kwargs["status"],
            sender=self.request.user,
        )


class FriendList(rest_framework.generics.ListAPIView):
    serializer_class = UserSerializer

    def get_queryset(self):
        return Friend.objects.friends(self.request.user)


# friend requests
class FriendRequests(rest_framework.generics.GenericAPIView):
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


class FriendActions(rest_framework.generics.GenericAPIView):
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
                return HttpResponse(
                    f"Sent friendship request to pk {other_user.id}.")
            except Exception as exception:
                return HttpResponse(str(exception), status=400)
        elif action == "accept":
            try:
                friend_request = FriendshipRequest.objects.get(
                    to_user=request.user.id, from_user=pk)
                friend_request.accept()
                return HttpResponse(f"Accepted friendship request from {pk}.")
            except Exception as exception:
                return HttpResponse(str(exception), status=400)
        elif action == "decline":
            try:
                friend_request = FriendshipRequest.objects.get(
                    to_user=request.user.id, from_user=pk)
                friend_request.decline()
                return HttpResponse(f"Declined friendship request from {pk}.")
            except Exception as exception:
                return HttpResponse(str(exception), status=400)
        elif action == "remove":
            try:
                Friend.objects.remove_friend(request.user, other_user)
                return HttpResponse(f"Removed friend {pk}.")
            except Exception as exception:
                return HttpResponse(str(exception), status=400)

        return HttpResponse("Invalid action.", status=400)

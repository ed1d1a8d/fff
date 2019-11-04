from datetime import datetime, timezone

from django.db import transaction
from django.db.models import Q
from django.http import HttpResponse, JsonResponse
from django.utils import timezone
import rest_framework.status
import rest_framework.generics
from rest_framework.response import Response
import requests
from rest_framework import parsers
import json
from django.db import models

from friendship.models import Friend, FriendshipRequest

from .models import FFRequest, FFRequestStatusEnum, User, Device
from .serializers import (
    FFRequestReadSerializer,
    FFRequestWriteSerializer,
    FriendshipRequestSerializer,
    LobbyExpirationSerializer,
    UserSelfSerializer,
    UserPublicSerializer,
)

from django.utils.dateparse import parse_datetime


class Dumb(rest_framework.generics.GenericAPIView):
    # return a response depending on the action passed in
    def get(self, request):
        return HttpResponse("dumb, but authenticated", status=200)


class SelfDetail(rest_framework.generics.RetrieveUpdateAPIView):
    serializer_class = UserSelfSerializer

    def get_object(self):
        return self.request.user


class AddFacebookFriends(rest_framework.generics.GenericAPIView):
    def post(self, request, format):
        url = "https://graph.facebook.com/v4.0/{0}/?fields=friends&access_token={1}".format(
            request.user.fb_id, request.data["access_token"])

        r = requests.get(url)
        returnlist = []

        if r.status_code == 200:
            existing_fff_friends = Friend.objects.friends(request.user)

            fbresponse = r.json()
            friendlist = fbresponse["friends"]["data"]

            for friend in friendlist:
                u = User.objects.get(fb_id=friend["id"])
                if (u not in existing_fff_friends):
                    serializer = UserPublicSerializer(u)
                    returnlist.append(serializer.data)

            return JsonResponse(returnlist, safe=False)

        return ("Error")


class DeviceView(rest_framework.generics.GenericAPIView):
    def put(self, request, registration_id):
        """Subscribe device to push notifications."""
        Device.objects.update_or_create(user=request.user,
                                        registration_id=registration_id)
        return Response(status=rest_framework.status.HTTP_201_CREATED)

    def delete(self, request, registration_id):
        """Unsubscribe device from push notifications."""
        Device.objects.filter(registration_id=registration_id).delete()
        return Response(status=rest_framework.status.HTTP_200_OK)


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
            # lazy ff request expiration
            if min(request.user.lobby_expiration,
                   new_lobby_expiration) < timezone.now():
                print(f"Deleting expired requests for {request.user}..."
                      )  # TODO: Replace with better logging.
                FFRequest.objects.filter(
                    status=FFRequestStatusEnum.PENDING.value,
                    sender=request.user).update(
                        status=FFRequestStatusEnum.EXPIRED.value)

            # print("Updating lobby expiration for a user from", repr(
            #     request.user.lobby_expiration), "to", repr(new_lobby_expiration))
            request.user.lobby_expiration = new_lobby_expiration
            request.user.save()

        return HttpResponse(status=200)


class LobbyFriends(rest_framework.generics.ListAPIView):
    serializer_class = UserPublicSerializer

    def get_queryset(self):
        return [
            f.from_user
            for f in Friend.objects.select_related("from_user").filter(
                to_user=self.request.user,
                from_user__lobby_expiration__gt=timezone.now()).all()
        ]


class CreateFFRequest(rest_framework.generics.CreateAPIView):
    serializer_class = FFRequestWriteSerializer

    def perform_create(self, serializer):
        ffrequest = serializer.save(
            status=FFRequestStatusEnum.PENDING.value,
            sender=self.request.user,
        )

    def create(self, request, *args, **kwargs):
        serializer = FFRequestWriteSerializer(data=request.data)
        if not serializer.is_valid():
            return Response(serializer.errors,
                            status=rest_framework.status.HTTP_400_BAD_REQUEST)
        receiver = serializer.validated_data["receiver"]
        if Friend.objects.are_friends(
                request.user, User.objects.get(pk=receiver.id)) != True:
            return HttpResponse(f"Can't send request to non-friends",
                                status=400)

        # create the request
        super().create(request, *args, **kwargs)

        # serialize the request and pass it back; the default create doesn't serialize the users
        # TODO: clean up
        newRequest = FFRequest.objects.get(
            sender=request.user,
            receiver=receiver,
            status=FFRequestStatusEnum.PENDING.value)
        # print(newRequest, repr(newRequest))
        responseSerializer = FFRequestReadSerializer(newRequest)
        return JsonResponse(responseSerializer.data, safe=False, status=201)


class RespondToFFRequest(rest_framework.generics.GenericAPIView):
    def post(self, request, pk, action):  # TODO: Redo status codes
        try:
            req = FFRequest.objects.get(pk=pk)
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

                # expire the user's lobby timer
                request.user.lobby_expiration = timezone.now()
                request.user.save()

            return HttpResponse(status=200)
        elif action == FFRequestStatusEnum.REJECTED.value:
            req.status = action
            req.save()
            return HttpResponse(status=200)
        else:
            return HttpResponse(f"Invalid action: {action}", status=400)


class CancelFFRequest(rest_framework.generics.GenericAPIView):
    def get(self, request, pk):
        try:
            req = FFRequest.objects.get(pk=pk)
        except:
            return HttpResponse(f"Request {pk} does not exist", status=400)

        if req.status != FFRequestStatusEnum.PENDING.value:
            return HttpResponse("Can't act on non-PENDING request", status=400)
        if req.sender != request.user:
            return HttpResponse(
                "Can't delete a request that the user didn't send", status=400)

        with transaction.atomic():
            req.status = FFRequestStatusEnum.CANCELLED.value
            req.save()
        return HttpResponse(status=200)


class FetchFFSearchForFriend(rest_framework.generics.ListAPIView):

    serializer_class = FFRequestReadSerializer

    def get_queryset(self):
        friend = User.objects.get(pk=self.kwargs['other_pk'])

        return FFRequest.objects.filter(
            (Q(sender=self.request.user) & Q(receiver=friend))
            | (Q(sender=friend) & Q(receiver=self.request.user)))


class IncomingFFRequests(rest_framework.generics.ListAPIView):
    # TODO: Double check you can only request a valid status

    serializer_class = FFRequestReadSerializer

    def get_queryset(self):
        requests = FFRequest.objects.filter(
            status=self.kwargs["status"],
            receiver=self.request.user,
        )  # .select_related("sender", "receiver")

        # filter for non-expired requests
        # FF requests are cancelled lazily - they are not cancelled when an
        # associated user's time expires, but only when either we retrieve the
        # request or the user updates their time
        # a request is expired when either of its users has expired
        filteredRequests = []
        for ffRequest in requests:
            if ffRequest.sender.lobby_expiration < timezone.now():
                print("FF Request lazily cancelled for sender",
                      ffRequest.sender, "expired at",
                      ffRequest.sender.lobby_expiration)
                with transaction.atomic():
                    ffRequest.status = FFRequestStatusEnum.EXPIRED.value
                    ffRequest.save()
                continue
            filteredRequests.append(ffRequest)

        return filteredRequests


class OutgoingFFRequests(rest_framework.generics.ListAPIView):
    # TODO: Filter to non-expired requests.
    serializer_class = FFRequestReadSerializer

    def get_queryset(self):
        requests = FFRequest.objects.filter(
            status=self.kwargs["status"],
            sender=self.request.user,
        )  # .select_related("sender", "receiver")

        # filter for non-expired requests - see above comment
        filteredRequests = []
        for ffRequest in requests:
            if ffRequest.receiver.lobby_expiration < timezone.now():
                print("FF Request lazily cancelled for receiver",
                      ffRequest.receiver, "expired at",
                      ffRequest.receiver.lobby_expiration)
                with transaction.atomic():
                    ffRequest.status = FFRequestStatusEnum.EXPIRED.value
                    ffRequest.save()
                continue
            filteredRequests.append(ffRequest)

        return filteredRequests


class FriendList(rest_framework.generics.ListAPIView):
    serializer_class = UserPublicSerializer

    def get_queryset(self):
        return Friend.objects.friends(self.request.user)


class NonFriendList(rest_framework.generics.ListAPIView):
    serializer_class = UserPublicSerializer

    def get_queryset(self):
        # TODO: Make this less jank.
        requestedUsers = FriendshipRequest.objects.select_related(
            "to_user").filter(from_user=self.request.user,
                              rejected__isnull=True).values_list("to_user",
                                                                 flat=True)
        return User.objects.exclude(
            friends__from_user=self.request.user).exclude(
                pk__in=requestedUsers).exclude(
                    id=self.request.user.id).exclude(is_superuser=True)


# friend requests
class FriendRequests(rest_framework.generics.GenericAPIView):
    # return a response depending on the action passed in
    def get(self, request, action):
        if action == "incoming":
            try:
                pending = Friend.objects.unrejected_requests(user=request.user)
                serializer = FriendshipRequestSerializer(pending, many=True)
                return JsonResponse(serializer.data, safe=False)
            except Exception as exception:
                return HttpResponse(str(exception), status=400)
        elif action == "outgoing":
            try:
                pending = FriendshipRequest.objects.select_related(
                    "from_user",
                    "to_user").filter(from_user=request.user,
                                      rejected__isnull=True).all()
                serializer = FriendshipRequestSerializer(pending, many=True)
                return JsonResponse(serializer.data, safe=False)
            except Exception as exception:
                return HttpResponse(str(exception), status=400)
        return HttpResponse("Invalid action.", status=400)


class FriendActions(rest_framework.generics.GenericAPIView):
    # return a response depending on the action passed in
    def post(self, request, action, pk):
        try:
            other_user = User.objects.get(pk=pk)
        except:
            return HttpResponse("User pk does not exist.", status=400)

        if action == "request":
            try:
                print("HELLO?????")
                Friend.objects.add_friend(request.user, other_user)
                print("YOOO)OOO!!!")
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


class GenerateMockDataForUser(rest_framework.generics.GenericAPIView):
    def post(self, request):
        # use default expiration
        # self.request.user.lobby_expiration = str(
        #     datetime(year=1970, month=1, day=1, tzinfo=timezone.utc))
        # request.user.save()
        for i, other_user in enumerate(
                User.objects.filter(is_superuser=False).all()):
            if self.request.user.id != other_user.id:
                Friend.objects.add_friend(self.request.user,
                                          other_user).accept()

                if i % 3 == 0:  # Outgoing request
                    tempRequest = FFRequest(
                        message="This is an outgoing request!",
                        status=FFRequestStatusEnum.PENDING.value,
                        sender=self.request.user,
                        receiver=other_user,
                    )
                    tempRequest.save()
                elif i % 3 == 1:  # Incoming request
                    tempRequest = FFRequest(
                        message="Yo this is an incoming request!",
                        status=FFRequestStatusEnum.PENDING.value,
                        sender=other_user,
                        receiver=self.request.user,
                    )
                    tempRequest.save()

        print(f"Generated mock data for {self.request.user}")

        return HttpResponse(status=200)

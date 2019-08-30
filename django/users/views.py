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
class FriendRequestsAction(generics.GenericAPIView):
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
                Friend.objects.add_friend(
                    request.user,
                    other_user)
                return HttpResponse("Sent friendship request to pk " + other_user.id)
            except Exception as exception:
                return HttpResponse(str(exception), status=400)
        elif action == "accept":
            friend_request = FriendshipRequest.objects.get(to_user=request.user.id)
            friend_request.accept()
        elif action == "decline":
            pass

        return HttpResponse("Invalid action.", status=400)

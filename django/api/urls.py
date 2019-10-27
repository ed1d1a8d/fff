from django.urls import include, path
from . import views

urlpatterns = [
    #path("profile/")
    #path("friends/")
    #path("search/")
    #path("lobby")
    #path("requests/")
    # Profile
    path("self/", views.SelfDetail.as_view()),

    # Lobby
    path("lobby/expiration/", views.LobbyExpiration.as_view()),
    path("lobby/friends/", views.LobbyFriends.as_view()),

    # Free for _ requests
    path("ffrequests/create/", views.CreateFFRequest.as_view()),
    path("ffrequests/incoming/<str:status>/",
         views.IncomingFFRequests.as_view()),
    path("ffrequests/outgoing/<str:status>/",
         views.OutgoingFFRequests.as_view()),
    path("ffrequests/respond/<int:pk>/<str:action>/",
         views.RespondToFFRequest.as_view()),
    path("ffrequests/search_friend_request/<int:other_pk>",
         views.FetchFFSearchForFriend.as_view()),

    # Friends
    path("friends/", views.FriendList.as_view()),
    path("friends/requests/<str:action>/", views.FriendRequests.as_view()),
    path("friends/actions/<str:action>/<int:pk>/",
         views.FriendActions.as_view()),
]

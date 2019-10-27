from django.conf import settings
from django.urls import include, path

from . import views

urlpatterns = [
    #path("profile/")
    #path("friends/")
    #path("search/")
    #path("lobby")
    #path("requests/")

    # Profile - gives information about the current logged in user
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
    path("ffrequests/cancel/<int:pk>/", views.CancelFFRequest.as_view()),
    path("ffrequests/search_friend_request/<int:other_pk>",
         views.FetchFFSearchForFriend.as_view()),

    # Friends
    path("friends/",
         views.FriendList.as_view()),  # Gives you list of user's friends
    path("fbfriends/", views.AddFacebookFriends.as_view()
         ),  # Gives you list of user's fb friends also on FFF
    path("friends/requests/<str:action>/", views.FriendRequests.as_view()),
    path("friends/actions/<str:action>/<int:pk>/",
         views.FriendActions.as_view()),
]

if settings.DEBUG:
    urlpatterns += [
        path("mockdata/generate_for_user/",
             views.GenerateMockDataForUser.as_view())
    ]

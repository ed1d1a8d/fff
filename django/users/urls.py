from django.urls import include, path
from . import views

urlpatterns = [
    path("self/", views.SelfDetail.as_view()),
    path("lobby-expiration/", views.LobbyExpiration.as_view()),
    # Requests
    path("requests/create/", views.CreateRequest.as_view()),
    path("requests/incoming/<str:status>/", views.IncomingRequests.as_view()),
    path("requests/outgoing/<str:status>/", views.OutgoingRequests.as_view()),
    path("requests/respond/<int:pk>/<str:action>/", views.RespondToRequest.as_view()),
    # Friends
    path("friends/", views.FriendList.as_view()),
    path("friends/requests/<str:action>/", views.FriendsRequests.as_view()),
    path("friends/actions/<str:action>/<int:pk>/",
         views.FriendsActions.as_view()),
]

from django.urls import include, path
from . import views

urlpatterns = [
    path("self/", views.SelfDetail.as_view()),
    path("friends/", views.FriendList.as_view()),
    path("friends/requests/<str:actions>/", views.FriendsRequests.as_view()),
    path("friends/actions/<str:action>/<int:pk>/",
         views.FriendsActions.as_view()),
]

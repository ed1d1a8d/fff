from django.urls import include, path
from . import views

urlpatterns = [
    path("self", views.SelfDetail.as_view()),
    path("friends", views.FriendList.as_view()),
    path("friends/<str:action>/<int:pk>",
         views.FriendRequestsAction.as_view()),
]

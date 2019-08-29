from django.urls import include, path
from rest_framework.urlpatterns import format_suffix_patterns
from . import views

urlpatterns = [
    path("self", views.SelfDetail.as_view()),
    path("friends", views.FriendList.as_view()),
    #path("friends/<int:pk>/", views.FriendDetail.as_view()),
]

urlpatterns = format_suffix_patterns(urlpatterns)

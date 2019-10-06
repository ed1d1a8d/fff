"""
fff URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/2.2/topics/http/urls/
"""
from allauth.socialaccount.providers.facebook.views import FacebookOAuth2Adapter
from django.contrib import admin
from django.contrib.staticfiles.urls import staticfiles_urlpatterns
from django.http import HttpResponse
from django.urls import include, path, re_path
from django.views.generic.base import RedirectView
from rest_auth.registration.views import SocialLoginView
from rest_framework.urlpatterns import format_suffix_patterns


# View for fb oauth
class FacebookLogin(SocialLoginView):
    adapter_class = FacebookOAuth2Adapter


urlpatterns = [
    path("auth/", include("rest_auth.urls")),

    # Registration has no trailing slash because we'll be using suffix patterns
    # on it anyway, and it's a single url and not a view.
    path("auth/registration", include("rest_auth.registration.urls")),

    # Social oauth for fb
    path("auth/facebook/", FacebookLogin.as_view()),

    # Auth'd endpoint for user stuff
    path("users/", include("users.urls")),
]
urlpatterns = format_suffix_patterns(urlpatterns, allowed=["json"])

# All the following urlpatterns end in /, since django will by default redirect
# patterns to / if it's a 404.
urlpatterns += [
    # Test endpoint for sanity checking
    path("dumb/", lambda request: HttpResponse("dumb")),

    # Default endpoint for admin actions
    path("admin/", admin.site.urls),

    # Joke endpoint for the favicon which probably won't be used
    path("favicon.ico/",
         RedirectView.as_view(url="/static/favicon.ico", permanent=True)),
]

urlpatterns += staticfiles_urlpatterns()

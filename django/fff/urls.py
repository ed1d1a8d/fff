"""fff URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/2.2/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path("", views.home, name="home")
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path("", Home.as_view(), name="home")
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path("blog/", include("blog.urls"))
"""
from django.contrib import admin
from django.urls import include, path, re_path
from django.http import HttpResponse
from rest_framework.urlpatterns import format_suffix_patterns
from django.contrib.staticfiles.urls import staticfiles_urlpatterns
from django.views.generic.base import RedirectView

urlpatterns = [
    path("auth/", include("rest_auth.urls")),

    # registration has no trailing slash because we'll be using suffix patterns on it anyway
    path("auth/registration", include("rest_auth.registration.urls")),
]
urlpatterns = format_suffix_patterns(urlpatterns, allowed=["json"])

# all the following urlpatterns end in /, since django will by default redirect
# patterns to / if it's a 404
urlpatterns += [
    # test endpoint for sanity checking
    path("dumb/", lambda request: HttpResponse("dumb")),

    # default endpoint for admin actions
    path("admin/", admin.site.urls),

    # joke endpoint for the favicon which probably won't be used
    path("favicon.ico/",
         RedirectView.as_view(url="/static/favicon.ico", permanent=True)),

    # auth'd endpoint for user stuff
    path("users/", include("users.urls")),
]
urlpatterns += staticfiles_urlpatterns()

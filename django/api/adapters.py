from allauth.account.adapter import DefaultAccountAdapter
from allauth.socialaccount.adapter import DefaultSocialAccountAdapter


class FFFSocialAccountAdapter(DefaultSocialAccountAdapter):
    def save_user(self, request, sociallogin, form):
        user = super().save_user(request, sociallogin, form)

        user_data = user.socialaccount_set.filter(provider='facebook')[0].extra_data
        picture_url = "http://graph.facebook.com/" + sociallogin.account.uid + "/picture?type=large"
        fb_id = sociallogin.account.uid

        user.image_url = picture_url
        user.fb_id = fb_id
        user.name = user_data["name"]
        user.save()

        return user

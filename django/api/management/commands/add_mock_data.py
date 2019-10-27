import random
from datetime import datetime, timezone

from django.core.management.base import BaseCommand
from django.contrib.sites.models import Site
from allauth.socialaccount.models import SocialApp, SocialAccount
from friendship.models import Friend, FriendshipRequest

from api.models import User, FFRequest, FFRequestStatusEnum


class Command(BaseCommand):
    args = ""
    help = "Adds mock data to the database"

    mock_user_data = [
        (
            "Edward Park",
            "edward.park.963",
            "",
            "https://scontent.fbed1-2.fna.fbcdn.net/v/t1.0-1/p100x100/67764166_1754110728066134_419834560717520896_n.jpg?_nc_cat=104&_nc_oc=AQncgbAQPz1r_rJy_7dW3zpJ5R5_A2fTDjvj7oPj3e6NjJS7hChgZP_kXDfb_FLHCsA&_nc_ht=scontent.fbed1-2.fna&oh=77c89b8df11a1f19592c5c5359e1f770&oe=5E3B0351",
        ),
        (
            "Stella Yang",
            "stellay",
            "stella.lan.yang@gmail.com",
            "https://scontent.fbed1-2.fna.fbcdn.net/v/t1.0-1/c73.206.614.614a/s200x200/50735968_2302236259809637_5312553092619698176_n.jpg?_nc_cat=104&_nc_oc=AQlHKJKlKDFPWN60047yu8FPgY8dh3cFCmxvwfapjP7fqwH7hr0iMfntNcqOLu8d_mM&_nc_ht=scontent.fbed1-2.fna&oh=413c43cfc473d21835aafd3887785360&oe=5E2E9C25",
        ),
        (
            "Jennifer Wang",
            "jennwang",
            "",
            "https://scontent.fbed1-2.fna.fbcdn.net/v/t1.0-1/p100x100/47687689_1488739577925807_9042020036373381120_n.jpg?_nc_cat=107&_nc_oc=AQmnMZm54OWVUQJtx8R_1jhezTCrNrLZx6A7KI8ZcSNdMYlUePw1t45iSMs3uVDAT_M&_nc_ht=scontent.fbed1-2.fna&oh=32a121a891b5eecf356fb23b9a65be28&oe=5DFC6F1D",
        ),
        (
            "Jing Lin",
            "jinglin",
            "",
            "https://scontent.fbed1-1.fna.fbcdn.net/v/t1.0-1/p100x100/58378676_2154998581255013_2664854016906756096_n.jpg?_nc_cat=100&_nc_oc=AQlH1dQaOh3xXehFINKExH8JFHTTcNdXY3eUdjlkYCCFPfF60e9zQ45ksL8_t8imilA&_nc_ht=scontent.fbed1-1.fna&oh=7db50a6238f1b0a1bb79473c1a137320&oe=5E310E0A",
        ),
        (
            "Ramya Nagarajan",
            "ramyan",
            "",
            "https://scontent.fbed1-1.fna.fbcdn.net/v/t1.0-1/p100x100/11822296_903047246417067_489206791595774145_n.jpg?_nc_cat=100&_nc_oc=AQndr9XMFK9s5TcBt6TBzjAIjq_WbDzIZI3dtqCiDmxdKsju6E1v60EjG-zzSwBX3Rc&_nc_ht=scontent.fbed1-1.fna&oh=d9360898c4109cbb87eec53e964b54ab&oe=5E2AC7A7",
        ),
        (
            "Tony Wang",
            "ed1d1a8d",
            "",
            "https://scontent.fbed1-1.fna.fbcdn.net/v/t1.0-1/p100x100/36260983_1748243281879694_1952299954449940480_n.jpg?_nc_cat=100&_nc_oc=AQn2TFJIbmv3O6tp3xheeAzeGU9lX6Nfl3ApqVgDURlsRYWkLljPydqLpoChhksSspw&_nc_ht=scontent.fbed1-1.fna&oh=075b9eaca2f69923f6b97b5e3d34c053&oe=5E353861",
        ),
        (
            "Yang Yan",
            "gilgamesh",
            "~@gilgamesh.cc",
            "https://scontent.fbed1-2.fna.fbcdn.net/v/t1.0-1/p100x100/71211524_2603049896407317_2196679779661381632_n.jpg?_nc_cat=104&_nc_oc=AQmc8MupAz9PReDNREdLOjmDiRzvKopWeCy-RxBTMq4EpAcm3MaZJ658gVHLYWLrMuI&_nc_ht=scontent.fbed1-2.fna&oh=22e17135b4cbdba9eb2b87f22406629d&oe=5E2A974F",
        ),
        (
            "Claire Yang",
            "claire.yangers",
            "",
            "https://scontent.fbed1-1.fna.fbcdn.net/v/t1.0-1/c99.208.603.603a/s100x100/69841000_2536178216610198_646550482520637440_n.jpg?_nc_cat=100&_nc_oc=AQnC9q0S2bVSflx8uQOkEzB1tpM5_MUwlmZ_vr-LtNgF9HFWO_UBm7VpXKrYz00uCIE&_nc_ht=scontent.fbed1-1.fna&oh=ba03d1e18599889e5a72edfa8ea347c2&oe=5DF7AD8C",
        ),
        (
            "Lydia Yang",
            "100018322293669",
            "",
            "https://scontent.fbed1-2.fna.fbcdn.net/v/t1.0-1/c0.0.100.100a/p100x100/19224940_102538797033530_6979691956426215845_n.jpg?_nc_cat=107&_nc_oc=AQnwBhq5_f3OkmN-LvlXAxNew4Ud_ym4LuKzfVNGTALZlgmrp7YlIUH78u_fHjHuPbk&_nc_ht=scontent.fbed1-2.fna&oh=ee466347215bca0fe06df8c414de0217&oe=5E25CBF6",
        )
    ]

    mock_message_data = [
      "hello",
      "world",
      "aiyee",
      "please",
      "work",
      "hello",
      "world",
      "aiyee",
      "please",
      "work",
    ]

    users = []

    def create_superuser(self):
        User.objects.create_superuser(username="admin",
                                      password="admin",
                                      email="")
        print("Created super user.")

    def create_mock_users(self):
        random.seed(42)
        for name, username, email, image_url in self.mock_user_data:
            self.users.append(
                User.objects.create_user(
                    username=username,
                    password="#yanggang",
                    name=name,
                    # email=email,
                    image_url=image_url,
                    longitude=-71.1097335 + 1 - 2 * random.random(),
                    latitude=42.3736158 + 1 - 2 * random.random(),
                    lobby_expiration=str(
                        datetime(year=2050,
                                 month=1,
                                 day=1,
                                 tzinfo=timezone.utc))))
        print(f"Created {len(self.users)} mock users.")

    def create_friendships(self):
        for i, user1 in enumerate(self.users):
            for user2 in self.users[2 * i + 1:]:
                Friend.objects.add_friend(user1, user2).accept()
        print(f"Created friendships")

    def create_mock_requests(self):
        for i, user1 in enumerate(self.users):
            for user2 in self.users[2 * i + 1:]:
                tempRequest = FFRequest(
                  message = self.mock_message_data[i],
                  status = FFRequestStatusEnum.PENDING.value,
                  sender = user1,
                  receiver = user2,)
                tempRequest.save()
        print(f"Created mock requests")

    def create_social_app(self):
        sapp = SocialApp(provider="facebook", name="Facebook", 
        client_id="379368956094614",
        secret="4d8dab44f8c87fab6c6a5384a58f7756")
        sapp.save()
        sapp.sites.add(1)

        # change site name to a custom name
        site = Site.objects.get(id=1)
        site.domain = "fff.gilgamesh.cc"
        site.name = "Free For Food - Gilgamesh"
        site.save()

        print(f"Created social app and changed default site")

    def handle(self, *args, **options):
        self.create_superuser()
        self.create_mock_users()
        self.create_friendships()
        self.create_mock_requests()
        self.create_social_app()

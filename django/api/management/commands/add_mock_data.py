import random
from datetime import datetime, timezone

from django.core.management.base import BaseCommand

from api.models import User


class Command(BaseCommand):
    args = ""
    help = "Adds mock data to the database"

    mock_user_data = [
        (
            "Edward Park",
            "edward.park.963",
            "https://scontent.fbed1-2.fna.fbcdn.net/v/t1.0-1/p100x100/67764166_1754110728066134_419834560717520896_n.jpg?_nc_cat=104&_nc_oc=AQncgbAQPz1r_rJy_7dW3zpJ5R5_A2fTDjvj7oPj3e6NjJS7hChgZP_kXDfb_FLHCsA&_nc_ht=scontent.fbed1-2.fna&oh=77c89b8df11a1f19592c5c5359e1f770&oe=5E3B0351",
        ),
        (
            "Jennifer Wang",
            "jennwang",
            "https://scontent.fbed1-2.fna.fbcdn.net/v/t1.0-1/p100x100/47687689_1488739577925807_9042020036373381120_n.jpg?_nc_cat=107&_nc_oc=AQmnMZm54OWVUQJtx8R_1jhezTCrNrLZx6A7KI8ZcSNdMYlUePw1t45iSMs3uVDAT_M&_nc_ht=scontent.fbed1-2.fna&oh=32a121a891b5eecf356fb23b9a65be28&oe=5DFC6F1D",
        ),
        (
            "Jing Lin",
            "jinglin",
            "https://scontent.fbed1-1.fna.fbcdn.net/v/t1.0-1/p100x100/58378676_2154998581255013_2664854016906756096_n.jpg?_nc_cat=100&_nc_oc=AQlH1dQaOh3xXehFINKExH8JFHTTcNdXY3eUdjlkYCCFPfF60e9zQ45ksL8_t8imilA&_nc_ht=scontent.fbed1-1.fna&oh=7db50a6238f1b0a1bb79473c1a137320&oe=5E310E0A",
        ),
        (
            "Ramya Nagarajan",
            "ramyan",
            "https://scontent.fbed1-1.fna.fbcdn.net/v/t1.0-1/p100x100/11822296_903047246417067_489206791595774145_n.jpg?_nc_cat=100&_nc_oc=AQndr9XMFK9s5TcBt6TBzjAIjq_WbDzIZI3dtqCiDmxdKsju6E1v60EjG-zzSwBX3Rc&_nc_ht=scontent.fbed1-1.fna&oh=d9360898c4109cbb87eec53e964b54ab&oe=5E2AC7A7",
        ),
        (
            "Tony Wang",
            "ed1d1a8d",
            "https://scontent.fbed1-1.fna.fbcdn.net/v/t1.0-1/p100x100/36260983_1748243281879694_1952299954449940480_n.jpg?_nc_cat=100&_nc_oc=AQn2TFJIbmv3O6tp3xheeAzeGU9lX6Nfl3ApqVgDURlsRYWkLljPydqLpoChhksSspw&_nc_ht=scontent.fbed1-1.fna&oh=075b9eaca2f69923f6b97b5e3d34c053&oe=5E353861",
        ),
        (
            "Yang Yan",
            "gilgamesh",
            "https://scontent.fbed1-2.fna.fbcdn.net/v/t1.0-1/p100x100/71211524_2603049896407317_2196679779661381632_n.jpg?_nc_cat=104&_nc_oc=AQmc8MupAz9PReDNREdLOjmDiRzvKopWeCy-RxBTMq4EpAcm3MaZJ658gVHLYWLrMuI&_nc_ht=scontent.fbed1-2.fna&oh=22e17135b4cbdba9eb2b87f22406629d&oe=5E2A974F",
        ),
        (
            "Claire Yang",
            "claire.yangers",
            "https://scontent.fbed1-1.fna.fbcdn.net/v/t1.0-1/c99.208.603.603a/s100x100/69841000_2536178216610198_646550482520637440_n.jpg?_nc_cat=100&_nc_oc=AQnC9q0S2bVSflx8uQOkEzB1tpM5_MUwlmZ_vr-LtNgF9HFWO_UBm7VpXKrYz00uCIE&_nc_ht=scontent.fbed1-1.fna&oh=ba03d1e18599889e5a72edfa8ea347c2&oe=5DF7AD8C",
        ),
        (
            "Lydia Yang",
            "100018322293669",
            "https://scontent.fbed1-2.fna.fbcdn.net/v/t1.0-1/c0.0.100.100a/p100x100/19224940_102538797033530_6979691956426215845_n.jpg?_nc_cat=107&_nc_oc=AQnwBhq5_f3OkmN-LvlXAxNew4Ud_ym4LuKzfVNGTALZlgmrp7YlIUH78u_fHjHuPbk&_nc_ht=scontent.fbed1-2.fna&oh=ee466347215bca0fe06df8c414de0217&oe=5E25CBF6",
        )
    ]

    def add_mock_users(self):
        User.objects.create_superuser(username="admin",
                                      password="admin",
                                      email="")
        print("Created super user.")

        random.seed(42)
        for name, username, image_url in self.mock_user_data:
            User.objects.create_user(
                username=username,
                password=username,
                name=name,
                image_url=image_url,
                longitude=-71.1097335 + 1 - 2 * random.random(),
                latitude=42.3736158 + 1 - 2 * random.random(),
                lobby_expiration=str(
                    datetime(year=2050, month=1, day=1, tzinfo=timezone.utc)))
        print(f"Added {len(self.mock_user_data)} mock users.")

    def handle(self, *args, **options):
        self.add_mock_users()

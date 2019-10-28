import "package:fff/models/user_data.dart";
import "package:fff/models/ffrequest.dart";

import "package:quiver/iterables.dart";

class MockData {
  static final Duration timerDuration = new Duration(minutes: 15);

  static final List<String> names = [
    "Edward Park",
    "Jennifer Wang",
    "Jing Lin",
    "Ramya Nagarajan",
    "Tony Wang",
    "Yang Yan",
    "Claire Yang",
    "Lydia Yang",
  ];

  static final List<String> usernames = [
    "edward.park.963",
    "jennwang",
    "jinglin",
    "ramyan",
    "ed1d1a8d",
    "gilgamesh",
    "claire.yangers",
    "100018322293669",
  ];

  static final List<double> longitudes = [
    -71.11,
    -71.12,
    -71.13,
    -71.14,
    -71.15,
    -71.16,
    -71.17,
    -71.18
  ];

  static final List<double> latitudes = [
    42.31,
    42.32,
    42.33,
    42.34,
    42.35,
    42.36,
    42.37,
    42.38,
  ];

  static final List<String> messages = [
    "Hey let's get beantown!",
    "Wanna get Anna's?",
    "Kenka! ^_^",
    "Let's get back together ;)",
    "AHHHHHH",
    "what message do i write here?",
    "I see you're a man of culture as well",
    "Huh?",
  ];

  static final List<String> imageURLs = <String>[
    "https://scontent.fbed1-2.fna.fbcdn.net/v/t1.0-1/p100x100/67764166_1754110728066134_419834560717520896_n.jpg?_nc_cat=104&_nc_oc=AQncgbAQPz1r_rJy_7dW3zpJ5R5_A2fTDjvj7oPj3e6NjJS7hChgZP_kXDfb_FLHCsA&_nc_ht=scontent.fbed1-2.fna&oh=77c89b8df11a1f19592c5c5359e1f770&oe=5E3B0351",
    "https://scontent.fbed1-2.fna.fbcdn.net/v/t1.0-1/p100x100/47687689_1488739577925807_9042020036373381120_n.jpg?_nc_cat=107&_nc_oc=AQmnMZm54OWVUQJtx8R_1jhezTCrNrLZx6A7KI8ZcSNdMYlUePw1t45iSMs3uVDAT_M&_nc_ht=scontent.fbed1-2.fna&oh=32a121a891b5eecf356fb23b9a65be28&oe=5DFC6F1D",
    "https://scontent.fbed1-1.fna.fbcdn.net/v/t1.0-1/p100x100/58378676_2154998581255013_2664854016906756096_n.jpg?_nc_cat=100&_nc_oc=AQlH1dQaOh3xXehFINKExH8JFHTTcNdXY3eUdjlkYCCFPfF60e9zQ45ksL8_t8imilA&_nc_ht=scontent.fbed1-1.fna&oh=7db50a6238f1b0a1bb79473c1a137320&oe=5E310E0A",
    "https://scontent.fbed1-1.fna.fbcdn.net/v/t1.0-1/p100x100/11822296_903047246417067_489206791595774145_n.jpg?_nc_cat=100&_nc_oc=AQndr9XMFK9s5TcBt6TBzjAIjq_WbDzIZI3dtqCiDmxdKsju6E1v60EjG-zzSwBX3Rc&_nc_ht=scontent.fbed1-1.fna&oh=d9360898c4109cbb87eec53e964b54ab&oe=5E2AC7A7",
    "https://scontent.fbed1-1.fna.fbcdn.net/v/t1.0-1/p100x100/36260983_1748243281879694_1952299954449940480_n.jpg?_nc_cat=100&_nc_oc=AQn2TFJIbmv3O6tp3xheeAzeGU9lX6Nfl3ApqVgDURlsRYWkLljPydqLpoChhksSspw&_nc_ht=scontent.fbed1-1.fna&oh=075b9eaca2f69923f6b97b5e3d34c053&oe=5E353861",
    "https://scontent.fbed1-2.fna.fbcdn.net/v/t1.0-1/p100x100/71211524_2603049896407317_2196679779661381632_n.jpg?_nc_cat=104&_nc_oc=AQmc8MupAz9PReDNREdLOjmDiRzvKopWeCy-RxBTMq4EpAcm3MaZJ658gVHLYWLrMuI&_nc_ht=scontent.fbed1-2.fna&oh=22e17135b4cbdba9eb2b87f22406629d&oe=5E2A974F",
    "https://scontent.fbed1-1.fna.fbcdn.net/v/t1.0-1/c99.208.603.603a/s100x100/69841000_2536178216610198_646550482520637440_n.jpg?_nc_cat=100&_nc_oc=AQnC9q0S2bVSflx8uQOkEzB1tpM5_MUwlmZ_vr-LtNgF9HFWO_UBm7VpXKrYz00uCIE&_nc_ht=scontent.fbed1-1.fna&oh=ba03d1e18599889e5a72edfa8ea347c2&oe=5DF7AD8C",
    "https://scontent.fbed1-2.fna.fbcdn.net/v/t1.0-1/c0.0.100.100a/p100x100/19224940_102538797033530_6979691956426215845_n.jpg?_nc_cat=107&_nc_oc=AQnwBhq5_f3OkmN-LvlXAxNew4Ud_ym4LuKzfVNGTALZlgmrp7YlIUH78u_fHjHuPbk&_nc_ht=scontent.fbed1-2.fna&oh=ee466347215bca0fe06df8c414de0217&oe=5E25CBF6",
  ];

  static final List<UserData> onlineFriends = [
    for (var pair
        in zip([names, usernames, imageURLs, longitudes, latitudes]).toList())
      UserData(
          name: pair[0],
          username: pair[1],
          imageUrl: pair[2],
          longitude: pair[3],
          latitude: pair[4])
  ];

  static final List<FFRequest> incomingRequests = [
    for (var pair
    in zip([names, usernames, imageURLs, longitudes, latitudes, messages])
        .toList()
        .sublist(0, 3))
      FFRequest(
        user: UserData(
            name: pair[0],
            username: pair[1],
            imageUrl: pair[2],
            longitude: pair[3],
            latitude: pair[4]),
        message: pair[5],
        isIncoming: true,
      )
  ];

  static final List<FFRequest> outgoingRequests = [
    for (var pair
    in zip([names, usernames, imageURLs, longitudes, latitudes, messages])
        .toList()
        .sublist(0, 3))
      FFRequest(
        user: UserData(
            name: pair[0],
            username: pair[1],
            imageUrl: pair[2],
            longitude: pair[3],
            latitude: pair[4]),
        message: pair[5],
        isIncoming: false,
      )
  ];
}


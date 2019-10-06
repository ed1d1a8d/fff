import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../components/hamburger_drawer.dart';
import '../utils/colors.dart' as fff_colors;

final List<String> requestNames = <String>[
  "Angela Cai",
  "Alisa Ono",
  "Florence Lo",
  "Annie Yun",
  "Andromeda",
  "Alstroemeria",
  "Animusphere",
];

final List<String> requestUsernames = <String>[
  "ayc111",
  "alisaono",
  "loflorence2",
  "lyunews",
  "cepheus",
  "shibayan",
  "olga-marie",
];

class FriendRequests extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FriendRequestsState();
}

class FriendRequestsState extends State<FriendRequests> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: fff_colors.white,
      endDrawer: HamburgerDrawer(),
      body: Container(
        constraints: BoxConstraints.expand(),
        child: Stack(
          children: <Widget>[
            // Custom positioning for the hamburger icon.
            Container(
              constraints: BoxConstraints.expand(),
              child: Column(
                children: <Widget>[
                  // Heading section
                  Container(
                    constraints:
                        BoxConstraints.tightFor(width: double.infinity),
                    color: fff_colors.background,
                    padding: const EdgeInsets.all(35),
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Column(
                            children: <Widget>[
                              Image.asset(
                                "assets/images/add-friends.png",
                                height: 80,
                              ),
                              Text(
                                "Friend Requests",
                                style: Theme.of(context).textTheme.display1,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Body section
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(
                        left: 35,
                        right: 35,
                        bottom: 35,
                      ),
                      child: Column(
                        children: <Widget>[
                          Container(
                            constraints:
                                BoxConstraints.tightFor(width: double.infinity),
                            margin: const EdgeInsets.symmetric(vertical: 25),
                            child: Text(
                              "Requests",
                              style: Theme.of(context).textTheme.body2,
                            ),
                          ),
                          Expanded(
                            child: ListView.separated(
                              padding: const EdgeInsets.only(),
                              itemCount: requestNames.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Row(
                                  children: <Widget>[
                                    CircleAvatar(
                                      radius: 25,
                                      backgroundImage: AssetImage(
                                        "assets/images/xiao-wang.jpg",
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(left: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            requestNames[index],
                                            style: Theme.of(context)
                                                .textTheme
                                                .body2,
                                          ),
                                          Text(
                                            "@" + requestUsernames[index],
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Spacer(),
                                    Column(
                                      children: <Widget>[
                                        Container(
                                          margin:
                                              const EdgeInsets.only(bottom: 5),
                                          width: 100,
                                          child: CupertinoButton(
                                            child: Text(
                                              "Accept",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .button,
                                            ),
                                            onPressed: () {},
                                            color: fff_colors.buttonGreen,
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 10,
                                              horizontal: 15,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 100,
                                          child: CupertinoButton(
                                            child: Text(
                                              "Delete",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .button,
                                            ),
                                            onPressed: () {},
                                            color: fff_colors.buttonGray,
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 10,
                                              horizontal: 15,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return Divider(
                                  color: fff_colors.black,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              right: 35,
              top: 35,
              child: IconButton(
                icon: Icon(Icons.menu),
                onPressed: () => scaffoldKey.currentState.openEndDrawer(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

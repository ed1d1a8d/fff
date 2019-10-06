import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../components/hamburger_drawer.dart';
import '../utils/colors.dart' as fff_colors;

final List<String> friendNames = <String>[
  "Angela Cai",
  "Alisa Ono",
  "Florence Lo",
];

class FriendRequests extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FriendRequestsState();
}

class FriendRequestsState extends State<FriendRequests> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

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
            Positioned(
              right: 35,
              top: 35,
              child: IconButton(
                icon: Icon(Icons.menu),
                onPressed: () => scaffoldKey.currentState.openEndDrawer(),
              ),
            ),
            Container(
              constraints: BoxConstraints.expand(),
              child: Column(
                children: <Widget>[
                  // Heading section
                  Container(
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
                  Container(
                    padding: const EdgeInsets.only(
                      left: 35,
                      right: 35,
                      bottom: 35,
                    ),
                    child: Text(
                      "body",
                      style: Theme.of(context).textTheme.display1,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

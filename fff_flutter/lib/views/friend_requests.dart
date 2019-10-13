import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";
import "package:fff/models/mock_data.dart";
import "package:fff/utils/colors.dart" as fff_colors;
import "package:fff/components/hamburger_drawer.dart";
import "package:fff/components/url_avatar.dart";

class FriendRequests extends StatefulWidget {
  static const String routeName = "/friend-requests";

  @override
  State<StatefulWidget> createState() => FriendRequestsState();
}

class FriendRequestsState extends State<FriendRequests> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Friend Requests",
          style: TextStyle(
            color: Colors.black,
            fontSize: 28,
          ),
        ),
        backgroundColor: fff_colors.background,
        elevation: 0.0,
        iconTheme: new IconThemeData(color: Colors.black),
      ),
      backgroundColor: fff_colors.white,
      drawer: HamburgerDrawer(),
      body: SafeArea(
        child: Container(
          constraints: BoxConstraints.expand(),
          child: Container(
            constraints: BoxConstraints.expand(),
            child: Column(
              children: <Widget>[
                // // Heading section
                // Container(
                //   constraints: BoxConstraints.tightFor(width: double.infinity),
                //   color: fff_colors.background,
                //   padding: const EdgeInsets.all(35),
                //   child: Column(
                //     children: <Widget>[
                //       Container(
                //         child: Column(
                //           children: <Widget>[
                //             Image.asset(
                //               "assets/images/add-friends.png",
                //               height: 80,
                //             ),
                //             Text(
                //               "Friend Requests",
                //               style: Theme.of(context).textTheme.display4,
                //             ),
                //           ],
                //         ),
                //       ),
                //     ],
                //   ),
                // ),

                // Body section
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(
                      top: 10,
                      left: 30,
                      right: 30,
                    ),
                    child: Column(
                      children: <Widget>[
                        // Container(
                        //   constraints:
                        //       BoxConstraints.tightFor(width: double.infinity),
                        //   margin: const EdgeInsets.symmetric(vertical: 25),
                        //   child: Text(
                        //     "Requests",
                        //     style: Theme.of(context).textTheme.body2,
                        //   ),
                        // ),
                        Expanded(
                          child: ListView.separated(
                            padding: const EdgeInsets.only(),
                            itemCount: MockData.onlineFriends.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Row(
                                children: <Widget>[
                                  URLAvatar(
                                    imageURL:
                                        MockData.onlineFriends[index].imageURL,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          MockData.onlineFriends[index].name,
                                          style: Theme.of(context)
                                              .textTheme
                                              .display2,
                                        ),
                                        Text(
                                          "@" +
                                              MockData.onlineFriends[index]
                                                  .username,
                                          style: Theme.of(context)
                                              .textTheme
                                              .display1,
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
                                        width: 85,
                                        height: 35,
                                        child: CupertinoButton(
                                          child: Text(
                                            "Accept",
                                            style: Theme.of(context)
                                                .textTheme
                                                .body1,
                                          ),
                                          onPressed: () {
                                            print("TODO BACKEND");
                                          },
                                          color: fff_colors.buttonGreen,
                                          padding: const EdgeInsets.all(0),
                                        ),
                                      ),
                                      Container(
                                        width: 85,
                                        height: 35,
                                        child: CupertinoButton(
                                          child: Text(
                                            "Delete",
                                            style: Theme.of(context)
                                                .textTheme
                                                .body1,
                                          ),
                                          onPressed: () {
                                            print("TODO BACKEND");
                                          },
                                          color: fff_colors.buttonGray,
                                          padding: const EdgeInsets.all(0),
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
        ),
      ),
    );
  }
}

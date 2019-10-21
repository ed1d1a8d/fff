import "package:fff/components/hamburger_drawer.dart";
import "package:fff/components/url_avatar.dart";
import "package:fff/models/mock_data.dart";
import "package:fff/backend/friend_requests.dart" as fff_backend_friend_requests;
import "package:fff/utils/colors.dart" as fff_colors;
import "package:fff/utils/spacing.dart" as fff_spacing;
import "package:flutter/material.dart";

class FriendRequests extends StatefulWidget {
  static const String routeName = "/friend-requests";

  @override
  State<StatefulWidget> createState() => FriendRequestsState();
}

class FriendRequestsState extends State<FriendRequests> {
  FriendRequestsState() {
    // do the initial fetch of data
    this._fetchData();
  }

  void _fetchData() {
    fff_backend_friend_requests.fetchUnrejectedRequests();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Container(
              height: 45, // TODO REMOVE HARDCODE
              padding: const EdgeInsets.only(right: 10),
              child: Image.asset(
                "assets/images/add-friends.png",
              ),
            ),
            Text(
              "Friend Requests",
              style: Theme.of(context).textTheme.title,
            ),
          ],
        ),
        backgroundColor: fff_colors.navBarBackground,
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
                // Body section
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(
                      top: 10,
                      left: fff_spacing.viewEdgeInsets,
                      right: fff_spacing.viewEdgeInsets,
                    ),
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: ListView.separated(
                            padding: const EdgeInsets.only(),
                            itemCount: MockData.onlineFriends.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Row(
                                children: <Widget>[
                                  URLAvatar(
                                    imageURL:
                                        MockData.onlineFriends[index].imageUrl,
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
                                        child: MaterialButton(
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
                                        child: MaterialButton(
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

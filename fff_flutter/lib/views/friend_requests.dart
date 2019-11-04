import "dart:async";
import "dart:developer";

import "package:fff/backend/friends.dart" as fff_backend_friends;
import "package:fff/components/hamburger_drawer.dart";
import "package:fff/components/url_avatar.dart";
import "package:fff/models/friend_request.dart";
import "package:fff/utils/colors.dart" as fff_colors;
import "package:fff/utils/no_delay_periodic_timer.dart";
import "package:fff/utils/spacing.dart" as fff_spacing;
import "package:flutter/material.dart";

class FriendRequests extends StatefulWidget {
  static const String routeName = "/friend-requests";

  @override
  State<StatefulWidget> createState() => FriendRequestsState();
}

class FriendRequestsState extends State<FriendRequests> {
  List<FriendRequest> _friendRequests;

  static const _fetchPeriod = const Duration(seconds: 10);
  Timer _fetchTimer;

  @override
  initState() {
    super.initState();

    _fetchTimer = noDelayPeriodicTimer(_fetchPeriod, this._fetchData);

    log("Initialized FriendRequestState.");
  }

  @override
  dispose() {
    log("dispose() called on FriendRequest.");
    _fetchTimer.cancel();
    super.dispose();
  }

  void _fetchData() async {
    final List<FriendRequest> newFriendRequests =
        await fff_backend_friends.fetchIncomingRequests();
    setState(() {
      _friendRequests = newFriendRequests;
    });
  }

  void _acceptRequest(FriendRequest fr) async {
    if (await fff_backend_friends.acceptRequest(fr)) {
      setState(() {
        _friendRequests.removeWhere((x) => x.id == fr.id);
      });
    }
  }

  void _declineRequest(FriendRequest fr) async {
    if (await fff_backend_friends.declineRequest(fr)) {
      setState(() {
        _friendRequests.removeWhere((x) => x.id == fr.id);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        title: Row(
          children: <Widget>[
            Container(
              height: 45,
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
                    child: _friendRequests == null
                        ? Center(child: CircularProgressIndicator())
                        : Column(
                            children: <Widget>[
                              Expanded(
                                child: ListView.separated(
                                  padding: const EdgeInsets.only(),
                                  itemCount: _friendRequests.length,
                                  itemBuilder:
                                      (BuildContext context, int index) =>
                                          buildFriendRequestRow(
                                              _friendRequests[index]),
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

  Widget buildFriendRequestRow(FriendRequest fr) => Row(
        children: <Widget>[
          URLAvatar(
            imageURL: fr.fromUser.imageUrl,
          ),
          Container(
            margin: const EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  fr.fromUser.name,
                  style: Theme.of(context).textTheme.display2,
                ),
                Text(
                  "@${fr.fromUser.username}",
                  style: Theme.of(context).textTheme.display1,
                ),
              ],
            ),
          ),
          Spacer(),
          Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(bottom: 5),
                width: 85,
                height: 35,
                child: MaterialButton(
                  child: Text(
                    "Accept",
                    style: Theme.of(context).textTheme.body1,
                  ),
                  onPressed: () => _acceptRequest(fr),
                  color: fff_colors.buttonGreen,
                  padding: const EdgeInsets.all(0),
                ),
              ),
              Container(
                width: 85,
                height: 35,
                child: MaterialButton(
                  child: Text(
                    "Decline",
                    style: Theme.of(context).textTheme.body1,
                  ),
                  onPressed: () => _declineRequest(fr),
                  color: fff_colors.buttonGray,
                  padding: const EdgeInsets.all(0),
                ),
              ),
            ],
          ),
        ],
      );
}

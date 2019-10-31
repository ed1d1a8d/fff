import "dart:async";

import "package:fff/backend/lobby.dart" as fff_lobby_backend;
import "package:fff/components/gradient_container.dart";
import "package:fff/components/hamburger_drawer.dart";
import "package:fff/components/timer_box.dart";
import "package:fff/components/url_avatar.dart";
import "package:fff/models/ffrequest.dart";
import "package:fff/models/mock_data.dart";
import "package:fff/models/user_data.dart";
import "package:fff/utils/colors.dart" as fff_colors;
import "package:fff/utils/no_delay_periodic_timer.dart";
import "package:fff/utils/spacing.dart" as fff_spacing;
import "package:fff/views/friend_detail.dart";
import "package:flutter/material.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:geolocator/geolocator.dart";
import "dart:developer";

enum _HomeTab { incomingRequests, onlineFriends, outgoingRequests }

class Home extends StatefulWidget {
  static const String routeName = "/home";

  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  _HomeTab _curTab = _HomeTab.incomingRequests;

  List<FFRequest> _incomingRequests;
  List<UserData> _onlineFriends;
  List<FFRequest> _outgoingRequests;

  static const _fetchPeriod = const Duration(seconds: 10);
  Timer _fetchTimer;

  static const _locationOptions =
      LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);
  StreamSubscription<Position> _positionSubscription;

  // the timerbox that we show here
  final TimerBox _fffTimerBox = new TimerBox();

  // helper function
  String _getHomeTabTitle(_HomeTab tab) {
    switch (tab) {
      case _HomeTab.incomingRequests:
        return "Incoming Requests";
      case _HomeTab.onlineFriends:
        return "Online Friends";
      case _HomeTab.outgoingRequests:
        return "Outgoing Requests";
    }
    return null;
  }

  @override
  initState() {
    super.initState();
    log("Initialized _HomeState.");

    // set the initial duration of the timerbox to a default when we first login
    // this function does nothing if the timerbox has already been set
    TimerBox.setInitialDuration(Duration(minutes: 10));

    _fetchTimer =
        noDelayPeriodicTimer(_fetchPeriod, this._handleFetchTimerCalled);
  }

  // returns a list containing 3 things: incomingRequests, onlineFriends, and outgoingRequests
  Future<List> _fetchLobbyData() async {
    List lobbyData;
    Position position;

    await Future.wait([
      () async {
        lobbyData = await Future.wait([
          fff_lobby_backend.fetchIncomingRequests(),
          fff_lobby_backend.fetchOnlineFriends(),
          fff_lobby_backend.fetchOutgoingRequests(),
        ]);
        log("Fetched lobby user data.");
      }(),
      () async {
        // do serially
        // the first geolocator call may trigger a request for permissions,
        // which will failed the second call if it is not yet resolved
        position = await Geolocator()
            .getCurrentPosition(desiredAccuracy: _locationOptions.accuracy);
        if (position == null) {
          position = await Geolocator()
              .getCurrentPosition(desiredAccuracy: _locationOptions.accuracy);
        }
        log("Fetched user position data.");
      }(),
    ]);

    if (position != null) {
      // TODO: Fix location subscription
      await Future.wait([
        _updateFFRequestDistances(position, lobbyData[0]),
        _updateUserDataDistances(position, lobbyData[1]),
        _updateFFRequestDistances(position, lobbyData[2]),
      ]);
      log("Updated positions of lobby friends.");
    }

    return lobbyData;
  }

  void _handleFetchTimerCalled() async {
    try {
      final List lobbyData = await this._fetchLobbyData();

      if (this.mounted) {
        setState(() {
          _incomingRequests = lobbyData[0];
          _onlineFriends = lobbyData[1];
          _outgoingRequests = lobbyData[2];
        });
      }
    } catch (error) {
      log("$error");
    }
  }

  Future _updateUserDataDistances(
      Position position, List<UserData> users) async {
    if (users == null) return;
    for (final user in users) {
      // TODO: Handle null positions for other users

      user.distance = await Geolocator().distanceBetween(
          position.latitude, position.longitude, user.latitude, user.longitude);
    }
    users.sort((u1, u2) => u1.distance.compareTo(u2.distance));
  }

  Future _updateFFRequestDistances(
      Position position, List<FFRequest> requests) async {
    // TODO: Handle null positions
    if (requests == null) return;
    for (final request in requests) {
      // TODO: Handle null positions for other users
      request.user.distance = await Geolocator().distanceBetween(
          position.latitude,
          position.longitude,
          request.user.latitude,
          request.user.longitude);
    }

    requests.sort((r1, r2) => r1.user.distance.compareTo(r2.user.distance));
  }

  @override
  dispose() {
    log("dispose() called on home.");
    _fetchTimer.cancel();
    _positionSubscription?.cancel();
    super.dispose();
  }

  void onTabTapped(int index) {
    setState(() {
      _curTab = _HomeTab.values[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: fff_colors.background,
      appBar: AppBar(
        brightness: Brightness.light,
        title: Text(
          this._getHomeTabTitle(_curTab),
          style: Theme.of(context).textTheme.title,
        ),
        backgroundColor: fff_colors.background,
        elevation: 0,
        iconTheme: new IconThemeData(color: Colors.black),
      ),
      drawer: HamburgerDrawer(),
      body: Container(
        padding: const EdgeInsets.only(
          left: fff_spacing.viewEdgeInsets,
          right: fff_spacing.viewEdgeInsets,
          bottom: fff_spacing.viewEdgeInsets,
        ),
        child: Column(
          children: <Widget>[
            Container(
              margin:
                  const EdgeInsets.only(bottom: fff_spacing.profilePicInsets),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 70,
                    height: 30,
                    margin: const EdgeInsets.only(
                        right: fff_spacing.profilePicInsets),
                    child: this._fffTimerBox,
                  ),
                  Text(
                    "minutes remaining",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        left: fff_spacing.profilePicInsets),
                    child: Icon(FontAwesomeIcons.questionCircle, size: 16),
                  ),
                ],
              ),
            ),
            buildProfileList(context),
          ],
        ),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          // sets the background color of the `BottomNavigationBar`
          canvasColor: fff_colors.navBarBackground,
          // sets the active color of the `BottomNavigationBar` if `Brightness` is light
          primaryColor: Colors.orange,
          textTheme: Theme.of(context).textTheme.copyWith(
                caption: new TextStyle(color: fff_colors.darkGray),
              ),
        ),
        // sets the inactive color of the `BottomNavigationBar`
        child: SizedBox(
          child: BottomNavigationBar(
            onTap: onTabTapped,
            currentIndex: _curTab.index,
            items: [
              BottomNavigationBarItem(
                icon: new Icon(Icons.mail),
                title: Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 6),
                  child: Text(
                    "Incoming Requests",
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ),
              BottomNavigationBarItem(
                icon: new Icon(Icons.person),
                title: Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 6),
                  child: Text(
                    "Online Friends",
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.paperPlane),
                title: Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 6),
                  child: Text(
                    "Outgoing Requests",
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildProfileList(BuildContext context) {
    final List<dynamic> data = () {
      switch (_curTab) {
        case _HomeTab.incomingRequests:
          return _incomingRequests;
        case _HomeTab.onlineFriends:
          return _onlineFriends;
        case _HomeTab.outgoingRequests:
          return _outgoingRequests;
      }
      return null;
    }();

    return Expanded(
      child: Container(
        color: fff_colors.background,
        child: GradientContainer(
          padding: const EdgeInsets.all(fff_spacing.profileListInsets),
          child: data == null
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.separated(
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (data[index] is UserData) {
                      return GestureDetector(
                        onTap: () =>
                            this._pushFriendDetail(context, data[index], null),
                        behavior: HitTestBehavior.translucent,
                        child: buildProfilePane(
                          data[index].imageUrl,
                          data[index].name,
                          data[index].distance,
                          null,
                        ),
                      );
                    }

                    // if data[index] is FFRequest
                    return GestureDetector(
                      onTap: () => this._pushFriendDetail(
                          context, data[index].user, data[index]),
                      behavior: HitTestBehavior.translucent,
                      child: buildProfilePane(
                        data[index].user.imageUrl,
                        data[index].user.name,
                        data[index].user.distance,
                        data[index].message,
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(
                    height: 20,
                    color: fff_colors.black,
                  ),
                ),
        ),
      ),
    );
  }

  Widget buildProfilePane(
      String imageURL, String name, double distance, String message) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding:
                    const EdgeInsets.only(right: fff_spacing.profilePicInsets),
                child: URLAvatar(
                  imageURL: imageURL,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    name,
                    style: Theme.of(context).textTheme.display2,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    distance == null
                        ? ""
                        : "${(distance / 1609.34).toStringAsFixed(2)} miles",
                    style: Theme.of(context).textTheme.display1,
                  ),
                ],
              ),
            ],
          ),
          message == null
              ? Container()
              : Container(
                  margin:
                      const EdgeInsets.only(top: fff_spacing.profilePicInsets),
                  child: Text(
                    message,
                    style: Theme.of(context).textTheme.body1,
                  ),
                ),
        ],
      ),
    );
  }

  _pushFriendDetail(BuildContext context, UserData user, FFRequest ffRequest) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FriendDetail(user, ffRequest),
      ),
    );
  }
}

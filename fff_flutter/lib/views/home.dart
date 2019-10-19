import "dart:async";

import "package:fff/backend/lobby.dart" as fff_lobby_backend;
import "package:fff/components/gradient_container.dart";
import "package:fff/components/hamburger_drawer.dart";
import "package:fff/components/timer_box.dart";
import "package:fff/components/url_avatar.dart";
import "package:fff/models/mock_data.dart";
import "package:fff/models/user_data.dart";
import "package:fff/models/ffrequest.dart";
import "package:fff/utils/colors.dart" as fff_colors;
import "package:fff/utils/no_delay_periodic_timer.dart";
import "package:fff/utils/spacing.dart" as fff_spacing;
import "package:fff/views/friend_detail.dart";
import "package:flutter/material.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import 'package:geolocator/geolocator.dart';

class Home extends StatefulWidget {
  static const String routeName = "/home";

  static final TimerBox timer = new TimerBox(MockData.timerDuration);

  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

enum _HomeTab { incomingRequests, onlineFriends, outgoingRequests }

String _homeTabToString(_HomeTab time) {
  switch (time) {
    case _HomeTab.incomingRequests:
      return "Incoming Requests";
    case _HomeTab.onlineFriends:
      return "Online Friends";
    case _HomeTab.outgoingRequests:
      return "Outgoing Requests";
  }
  return null;
}

class _HomeState extends State<Home> {
  _HomeTab _curTab = _HomeTab.incomingRequests;

  // TODO: Use a different datatype for requests.
  List<FFRequest> _incomingRequests; // TODO: Track unread requests.
  List<UserData> _onlineFriends;
  List<FFRequest> _outgoingRequests;

  Timer _fetchTimer;
  static const _fetchPeriod = const Duration(seconds: 5);

  StreamSubscription<Position> _positionSubscription;

  @override
  initState() {
    super.initState();

    _fetchTimer = noDelayPeriodicTimer(_fetchPeriod, () async {
      try {
        final List<UserData> newOnlineFriends =
            await fff_lobby_backend.fetchOnlineFriends();
        print("Fetched new lobby friends");

        final List<FFRequest> newIncomingRequests =
            await fff_lobby_backend.fetchIncomingRequests();

        final List<FFRequest> newOutgoingRequests =
            await fff_lobby_backend.fetchOutgoingRequests();

        setState(() {
          _onlineFriends = newOnlineFriends;
          _incomingRequests = newIncomingRequests;
          _outgoingRequests = newOutgoingRequests;
        });
      } catch (error) {
        print("Failed to fetch friends. $error");
      }
    });

    _positionSubscription = Geolocator()
        .getPositionStream(LocationOptions(
            accuracy: LocationAccuracy.high, distanceFilter: 10))
        .listen((Position position) async {
      final getDistance = (UserData userData) async => position == null
          ? null
          : await Geolocator().distanceBetween(position.latitude,
              position.longitude, userData.latitude, userData.longitude);

      final List<double> incomingRequestDists = _incomingRequests == null
          ? null
          : await Future.wait(
              _incomingRequests.map((request) => getDistance(request.user)));

      final List<double> onlineFriendsDists = _onlineFriends == null
          ? null
          : await Future.wait(_onlineFriends?.map(getDistance));

      final List<double> outgoingRequestDists = _outgoingRequests == null
          ? null
          : await Future.wait(
              _incomingRequests.map((request) => getDistance(request.user)));

      print("Got new location and updated distances");
      setState(() {
        incomingRequestDists.asMap().forEach((idx, dist) {
          _incomingRequests[idx].user.distance = dist;
        });
        _incomingRequests
            .sort((r1, r2) => r1.user.distance.compareTo(r2.user.distance));

        onlineFriendsDists.asMap().forEach((idx, dist) {
          _onlineFriends[idx].distance = dist;
        });
        _onlineFriends.sort((u1, u2) => u1.distance.compareTo(u2.distance));

        outgoingRequestDists.asMap().forEach((idx, dist) {
          _outgoingRequests[idx].user.distance = dist;
        });
        _outgoingRequests
            .sort((r1, r2) => r1.user.distance.compareTo(r2.user.distance));
      });
    });
  }

  @override
  dispose() {
    _fetchTimer.cancel();
    _positionSubscription.cancel();
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
        title: Text(
          _homeTabToString(_curTab),
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
                    child: Home.timer,
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
                      onTap: () =>
                          this._pushFriendDetail(context, data[index].user, data[index]),
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

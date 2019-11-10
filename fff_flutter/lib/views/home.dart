import "dart:async";

import "package:fff/backend/lobby.dart" as fff_lobby_backend;
import "package:fff/backend/constants.dart" as fff_backend_constants;
import "package:fff/backend/auth.dart" as fff_auth;
import "package:fff/components/gradient_container.dart";
import "package:fff/components/hamburger_drawer.dart";
import "package:fff/components/timer_box.dart";
import "package:fff/backend/fff_timer.dart" as backend_timer;
import "package:fff/components/url_avatar.dart";
import "package:fff/models/ffrequest.dart";
import "package:fff/models/user_data.dart";
import "package:fff/utils/colors.dart" as fff_colors;
import "package:fff/utils/no_delay_periodic_timer.dart";
import "package:fff/utils/spacing.dart" as fff_spacing;
import "package:fff/views/friend_detail.dart";
import "package:fff/views/fff_timer_expired.dart";
import "package:fff/views/login.dart";
import "package:flutter/material.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:geolocator/geolocator.dart";
import "dart:developer";
import "package:http/http.dart" as http;
import "package:badges/badges.dart";

enum _HomeTab { incomingRequests, onlineFriends, outgoingRequests }

enum Detail { incoming, online, outgoing }

class Home extends StatefulWidget {
  static const String routeName = "/home";

  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }

  // used on logout
  static void resetFetchBackendTimer() {
    _HomeState._fetchBackendTimer.cancel();
    _HomeState._fetchBackendTimer = null;
  }

  // for on launch or on push
  static Future shortCircuitFetchBackendTimer() async {
    await _HomeState._handleFetchTimerCalled();
  }
}

class _HomeState extends State<Home> {
  static const _fetchPeriod = const Duration(seconds: 10);
  static const _locationOptions =
      LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);

  // the timerbox that we show here
  final TimerBox _fffTimerBox = new TimerBox();

  // request the backend every _fetchPeriod; timer runs even when page is not mounted
  static Timer _fetchBackendTimer;
  static Set<_HomeState> _mountedInstances = Set();
  static BuildContext _mountedContext;

  // lobby information - kept updated by _fetchBackendTimer;
  static List<FFRequest> _incomingRequests;
  static List<UserData> _onlineFriends;
  static List<FFRequest> _outgoingRequests;

  _HomeTab _curTab = _HomeTab.incomingRequests;
  StreamSubscription<Position> _positionSubscription;

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

  Widget _getBody(_HomeTab tab, data) {
    if (data == null) {
      // If the data has not returned yet, show progress spinner
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    if (backend_timer.hasExpired()) {
      // If timer has expired, show timer expiration info
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Your timer has expired.",
              style: Theme.of(context).textTheme.display2),
          SizedBox(height: 12),
          Text(
              "To go back online and see friends and requests, please update your timer.",
              style: Theme.of(context).textTheme.display2),
        ],
      );
    } else if (data.length == 0) {
      // If their list is empty, show special text by tab
      return _getNoneText(tab);
    } else {
      // OTHERWISE Show friend list
      return ListView.separated(
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          if (data[index] is UserData) {
            return GestureDetector(
              onTap: () => this._pushFriendDetail(context, data[index], null),
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
            onTap: () =>
                this._pushFriendDetail(context, data[index].user, data[index]),
            behavior: HitTestBehavior.translucent,
            child: buildProfilePane(
              data[index].user.imageUrl,
              data[index].user.name,
              data[index].user.distance,
              data[index].message,
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(
          height: 20,
          color: fff_colors.black,
        ),
      );
    }
  }

  Column _getNoneText(_HomeTab tab) {
    switch (tab) {
      case _HomeTab.incomingRequests:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("You have no incoming requests.",
                style: Theme.of(context).textTheme.display2),
          ],
        );
      case _HomeTab.onlineFriends:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("None of your friends are currently online.",
                style: Theme.of(context).textTheme.display2),
            SizedBox(height: 12),
            Text("Try adding more through the hamburger menu.",
                style: Theme.of(context).textTheme.display2),
          ],
        );
      case _HomeTab.outgoingRequests:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("You have no outgoing requests.",
                style: Theme.of(context).textTheme.display2),
            SizedBox(height: 12),
            Text("Send some through the Online Friends tab.",
                style: Theme.of(context).textTheme.display2),
          ],
        );
    }
    return null;
  }

  @override
  initState() {
    super.initState();
    log("Initialized _HomeState.");
    _HomeState._mountedContext = this.context;
    _HomeState._mountedInstances.add(this);

    if (_HomeState._fetchBackendTimer == null) {
      _HomeState._fetchBackendTimer = noDelayPeriodicTimer(
          _fetchPeriod, _HomeState._handleFetchTimerCalled);
    }
  }

  static Future _handleFetchTimerCalled() async {
    try {
      // only fetch data if the timer has not expired yet and not showing accepted screen
      if (!FFFTimerExpired.mounted && !FriendDetail.isShowingAcceptedView()) {
        final List<List> lobbyData = await _HomeState._fetchLobbyData();

        // make changes to the static data - and call setstate if we're mounted
        Function updateStaticData = () {
          _HomeState._incomingRequests = lobbyData[0];
          _HomeState._onlineFriends = lobbyData[1];
          _HomeState._outgoingRequests = lobbyData[2];
        };

        if (_HomeState._mountedInstances.length == 0) {
          updateStaticData();
          log("Fetched lobby data.");
        } else {
          for (_HomeState instance in _HomeState._mountedInstances) {
            log("Fetched lobby data and called setState on Home instance.");
            instance.setState(updateStaticData);
          }
        }
      }
    } catch (error) {
      log("$error");
    }
  }

  // returns a list containing 3 things: incomingRequests, onlineFriends, and outgoingRequests
  static Future<List<List>> _fetchLobbyData() async {
    List<List> lobbyData;
    Position position;

    await Future.wait([
      () async {
        lobbyData = await Future.wait([
          fff_lobby_backend.fetchIncomingRequests(),
          fff_lobby_backend.fetchOnlineFriends(),
          fff_lobby_backend.fetchOutgoingRequests(),
        ]);
        // log("Fetched lobby user data.");

        // filter the online friends for those who don't have a request associated with them as well
        // TODO: assume here that you can't have an incoming and outgoing request to the same user at one time
        Set<int> requestedUserIds = new Set<int>();
        for (FFRequest request in lobbyData[0]) {
          requestedUserIds.add(request.user.id);
        }
        for (FFRequest request in lobbyData[2]) {
          requestedUserIds.add(request.user.id);
        }

        List<UserData> filteredOnlineFriends = new List<UserData>();
        for (UserData userData in lobbyData[1]) {
          if (requestedUserIds.contains(userData.id)) continue;
          filteredOnlineFriends.add(userData);
        }
        lobbyData[1] = filteredOnlineFriends;
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
        // log("Fetched user position data.");
      }(),
      () async {
        // pull any accepted FF requests that we haven't marked as read yet
        List<FFRequest> unreadRequests =
            await fff_lobby_backend.fetchUnreadAcceptedFFRequests();

        // if this list isn't empty, then update the view immediately to the accepted screen
        if (unreadRequests.length > 0) {
          FFRequest request = unreadRequests[0];

          Navigator.push(
            _HomeState._mountedContext,
            MaterialPageRoute(
              builder: (context) => FriendDetail(
                request.user,
                request,
                () {},
                showingAcceptedView: true,
              ),
            ),
          );
        }
      }(),
    ]);

    if (position != null) {
      await Future.wait([
        _updateFFRequestDistances(position, lobbyData[0]),
        _updateUserDataDistances(position, lobbyData[1]),
        _updateFFRequestDistances(position, lobbyData[2]),
        () async {
          UserData updatedMe = UserData(
            latitude: position.latitude,
            longitude: position.longitude,
            id: me.id,
            username: me.username,
            name: me.name,
            facebookId: me.facebookId,
            imageUrl: me.imageUrl,
            message: me.message,
            lastFoodDate: me.lastFoodDate,
          );
          me = updatedMe;
          // log("lat " + me.latitude.toString() + " lng " + me.longitude.toString());

          // send the position to the backend
          await http.put(
            fff_backend_constants.server_location + "/api/self/detail.json/",
            body: {
              "latitude": position.latitude.toString(),
              "longitude": position.longitude.toString(),
            },
            headers: fff_auth.getAuthHeaders(),
          );
        }(),
      ]);
      // log("Updated positions of lobby friends.");
    }

    return lobbyData;
  }

  static Future _updateUserDataDistances(
      Position position, List<UserData> users) async {
    if (users == null) return;
    for (final user in users) {
      if (user.latitude == null ||
          user.longitude == null ||
          position.latitude == null ||
          position.longitude == null) {
        user.distance = double.infinity;
      } else {
        user.distance = await Geolocator().distanceBetween(position.latitude,
            position.longitude, user.latitude, user.longitude);
      }
    }
    users.sort((u1, u2) => u1.distance.compareTo(u2.distance));
  }

  static Future _updateFFRequestDistances(
      Position position, List<FFRequest> requests) async {
    if (requests == null) return;
    for (final request in requests) {
      if (request.user.latitude == null ||
          request.user.longitude == null ||
          position.latitude == null ||
          position.longitude == null) {
        request.user.distance = double.infinity;
      } else {
        request.user.distance = await Geolocator().distanceBetween(
            position.latitude,
            position.longitude,
            request.user.latitude,
            request.user.longitude);
      }
    }

    requests.sort((r1, r2) => r1.user.distance.compareTo(r2.user.distance));
  }

  @override
  dispose() {
    log("dispose() called on Home.");
    _positionSubscription?.cancel();
    _HomeState._mountedInstances.remove(this);
    super.dispose();
  }

  void onTabTapped(int index) {
    setState(() {
      _curTab = _HomeTab.values[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    int incomingLength = _HomeState._incomingRequests == null
        ? 0
        : _HomeState._incomingRequests.length;
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
                icon: incomingLength == 0
                    ? new Icon(Icons.mail)
                    : Badge(
                        badgeColor: fff_colors.badgeColor,
                        badgeContent: Text(incomingLength.toString()),
                        child: new Icon(Icons.mail),
                      ),
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
          return _HomeState._incomingRequests;
        case _HomeTab.onlineFriends:
          return _HomeState._onlineFriends;
        case _HomeTab.outgoingRequests:
          return _HomeState._outgoingRequests;
      }
      return null;
    }();

    return Expanded(
      child: Container(
        color: fff_colors.background,
        child: GradientContainer(
            padding: const EdgeInsets.all(fff_spacing.profileListInsets),
            child: _getBody(_curTab, data)),
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
                    distance == double.infinity
                        ? ""
                        : (distance == null
                            ? ""
                            : "${(distance / 1609.34).toStringAsFixed(2)} miles"),
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
        builder: (context) => FriendDetail(
          user,
          ffRequest,
          (Detail detail, FFRequest ffRequest, bool incomingRequestAccepted) {
            if (detail == Detail.outgoing) {
              // this callback means the outgoing request was withdrawn
              // print("start");
              // print(_HomeState._outgoingRequests.length);
              this.setState(() {
                _HomeState._outgoingRequests.removeWhere(
                    (request) => request.user.id == ffRequest.user.id);

                // add back to online friends
                _HomeState._onlineFriends.add(ffRequest.user);
              });
              // print(_HomeState._outgoingRequests.length);
              // print("end");
            } else if (detail == Detail.online) {
              // this means an outgoing request was sent
              this.setState(() {
                // TODO: this doesn't work too well
                log(ffRequest.toString());
                _HomeState._outgoingRequests.insert(0, ffRequest);
                this._curTab = _HomeTab.outgoingRequests;

                // filter out online friends for this requested friend
                _HomeState._onlineFriends
                    .removeWhere((user) => user.id == ffRequest.user.id);
              });
            } else {
              // incoming request was either accepted or rejected
              // use the incomingRequestAccepted flag to check this
              this.setState(() {
                _HomeState._incomingRequests.removeWhere(
                    (request) => request.user.id == ffRequest.user.id);
              });

              // if accepted an incoming request
              if (incomingRequestAccepted == true) {
                log("Accepted an incoming request. Showing accepted view...");

                // push onto the navigator
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FriendDetail(
                      user,
                      ffRequest,
                      () {},
                      showingAcceptedView: true,
                    ),
                  ),
                );
              } else {
                // add back to online friends
                this.setState(() {
                  _HomeState._onlineFriends.add(ffRequest.user);
                });
              }
            }
          },
        ),
      ),
    );
  }
}

import "dart:developer";
import "package:firebase_messaging/firebase_messaging.dart";
import "package:flutter/material.dart";

import "package:fff/routes.dart" as fff_routes;
import "package:fff/utils/theme.dart";
import 'package:fff/views/add_fb_friends.dart';
import "package:fff/views/add_friends_signup.dart";
import "package:fff/views/fff_timer_expired.dart";
import "package:fff/views/friend_requests.dart";
import "package:fff/views/home.dart";
import "package:fff/views/loading.dart";
import "package:fff/views/login.dart";
import "package:fff/views/search_people.dart";
import "package:fff/components/timer_box.dart";

void main() => runApp(FFFApp());

class FFFApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FFFAppState();
}

class _FFFAppState extends State<FFFApp> {
  final FirebaseMessaging _fcm = FirebaseMessaging();

  _FFFAppState() {
    log("_FFFAppState initialized.");
  }

  @override
  void initState() {
    super.initState();

    // noop on android
    _fcm.requestNotificationPermissions();

    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        log("onMessage: $message");
        await Home.shortCircuitFetchBackendTimer();
      },
      // fires if the app is fully terminated
      onLaunch: (Map<String, dynamic> message) async {
        log("onLaunch: $message");
        await Home.shortCircuitFetchBackendTimer();
      },
      // fires if the app is closed, but still running in the background
      onResume: (Map<String, dynamic> message) async {
        log("onResume: $message");
        await Home.shortCircuitFetchBackendTimer();
      },
    );
  }

  Function _buildRoute(Widget route) {
    return (BuildContext context) {
      TimerBox.setGlobalContextFromMain(context);
      return route;
    };
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,

      // Switch this line out for easier debugging
      home: Loading(),
      // home: Login(),
      // home: AddFriendsSignup(),
      // home: Home(),
      // home: SearchPeople(),

      // Used by the navigator.
      routes: <String, WidgetBuilder>{
        fff_routes.loading: this._buildRoute(Loading()),
        fff_routes.login: this._buildRoute(Login()),
        fff_routes.home: this._buildRoute(Home()),
        fff_routes.friendRequest: this._buildRoute(FriendRequests()),
        fff_routes.addFriendsSignup: this._buildRoute(AddFriendsSignup()),
        fff_routes.searchPeople: this._buildRoute(SearchPeople()),
        fff_routes.addFBFriends: this._buildRoute(AddFBFriends()),
        fff_routes.fffTimerExpired: this._buildRoute(FFFTimerExpired()),
      },
    );
  }
}

import "dart:developer";
import "dart:async";

import "package:fff/routes.dart" as fff_routes;
import "package:fff/utils/theme.dart";
import "package:fff/views/add_fb_friends.dart";
import "package:fff/views/add_friends_signup.dart";
import "package:fff/views/fff_timer_expired.dart";
import "package:fff/views/friend_requests.dart";
import "package:fff/views/home.dart";
import "package:fff/views/loading.dart";
import "package:fff/views/login.dart";
import "package:fff/views/search_people.dart";
import "package:firebase_messaging/firebase_messaging.dart";
import "package:flutter/material.dart";
import "package:fff/backend/fff_timer.dart" as fff_backend_timer;

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
        fff_routes.loading: (_) => Loading(),
        fff_routes.login: (_) => Login(),
        fff_routes.home: (_) => Home(),
        fff_routes.friendRequest: (_) => FriendRequests(),
        fff_routes.addFriendsSignup: (_) => AddFriendsSignup(),
        fff_routes.searchPeople: (_) => SearchPeople(),
        fff_routes.addFBFriends: (_) => AddFBFriends(),
        fff_routes.fffTimerExpired: (_) => FFFTimerExpired(),
      },
    );
  }
}

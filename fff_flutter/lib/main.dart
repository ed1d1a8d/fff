import "dart:developer";

import "package:fff/routes.dart" as fff_routes;
import "package:fff/utils/theme.dart";
import "package:fff/views/add_friends_signup.dart";
import "package:fff/views/friend_requests.dart";
import "package:fff/views/home.dart";
import "package:fff/views/loading.dart";
import "package:fff/views/login.dart";
import 'package:fff/views/search_people.dart';
import "package:fff/components/timer_box.dart";
import "package:firebase_messaging/firebase_messaging.dart";
import "package:flutter/material.dart";

void main() => runApp(FFFApp());

class FFFApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FFFAppState();
}

class _FFFAppState extends State<FFFApp> {
  final TimerBox fffTimer = new TimerBox(new Duration(minutes: 15));
  final FirebaseMessaging _fcm = FirebaseMessaging();

  _FFFAppState() {
    log("_FFFAppState initialized.");
  }

  @override
  void initState() {
    super.initState();

    // noop on android
    _fcm.requestNotificationPermissions(IosNotificationSettings());

    _fcm.configure(
      // fires if the app is fully terminated
      onLaunch: (Map<String, dynamic> message) async {
        log("onLaunch: $message");
        // TODO: Navigate to specific message screen.
      },
      // fires if the app is closed, but still running in the background
      onResume: (Map<String, dynamic> message) async {
        log("onResume: $message");
        // TODO: Navigate to specific message screen.
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,

      // Switch this line out for easier debugging
      // home: Loading(),
      home: Login(),
      // home: AddFriendsSignup(),
      // home: Home(),
      // home: SearchPeople(),

      // Used by the navigator.
      routes: <String, WidgetBuilder>{
        fff_routes.loading: (BuildContext context) => Loading(),
        fff_routes.login: (BuildContext context) => Login(),
        fff_routes.home: (BuildContext context) => Home(this.fffTimer),
        fff_routes.friendRequest: (BuildContext context) => FriendRequests(),
        fff_routes.addFriendSignup: (BuildContext context) =>
            AddFriendsSignup(),
        fff_routes.searchPeople: (BuildContext context) => SearchPeople(),
      },
    );
  }
}

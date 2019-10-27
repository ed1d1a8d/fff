import "package:fff/routes.dart" as fff_routes;
import "package:fff/utils/theme.dart";
import "package:fff/views/add_friends_signup.dart";
import "package:fff/views/friend_requests.dart";
import "package:fff/views/home.dart";
import "package:fff/views/loading.dart";
import "package:fff/views/login.dart";
import 'package:fff/views/search_people.dart';
import "package:firebase_messaging/firebase_messaging.dart";
import "package:flutter/material.dart";

void main() => runApp(FFFApp());

class FFFApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FFFAppState();
}

class _FFFAppState extends State<FFFApp> {
  final FirebaseMessaging _fcm = FirebaseMessaging();

  @override
  void initState() {
    super.initState();

    // noop on android
    _fcm.requestNotificationPermissions(IosNotificationSettings());

    _fcm.configure(
      // fires if the app is fully terminated
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        // TODO: Navigate to specific message screen.
      },
      // fires if the app is closed, but still running in the background
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
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
        fff_routes.home: (BuildContext context) => Home(),
        fff_routes.friendRequest: (BuildContext context) => FriendRequests(),
        fff_routes.addFriendSignup: (BuildContext context) =>
            AddFriendsSignup(),
        fff_routes.searchPeople: (BuildContext context) => SearchPeople(),
      },
    );
  }
}

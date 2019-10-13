import "package:flutter/material.dart";
import "package:fff/utils/theme.dart";
import "package:fff/views/home.dart";
import "package:fff/views/add_friends_signup.dart";
import "package:fff/views/friend_requests.dart";
import "package:fff/routes/routes.dart";

void main() => runApp(FFFApp());

class FFFApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      
      // Since we don't have animations between view widgets yet, to test, just switch this line out.
      home: Home(),
      // home: AddFriendsSignup(),
      // home: FriendRequests(),

      // Used by the navigator.
      routes: <String, WidgetBuilder>{
        Routes.friendRequest: (BuildContext context) => FriendRequests(),
        Routes.addFriendSignup: (BuildContext context) => AddFriendsSignup(),
      },
    );
  }
}

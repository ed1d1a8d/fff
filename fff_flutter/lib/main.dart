import 'package:flutter/material.dart';
import 'views/add_friends_signup.dart';
import 'views/home.dart';

void main() => runApp(FFFApp());

class FFFApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Since we don't have animations between view widgets yet, to test, just switch this line out.
      home: Home(),
      // home: AddFriendsSignup(),
    );
  }
}

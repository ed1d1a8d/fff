import 'package:flutter/material.dart';
import 'views/home.dart';
import 'views/add_friends_signup.dart';
import 'views/friend_requests.dart';
import 'utils/colors.dart' as fff_colors;

void main() => runApp(FFFApp());

class FFFApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // Define the default font family.
        fontFamily: 'Muli',

        // Define the default TextTheme. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: const TextTheme(
          display1: const TextStyle(
            fontSize: 26.0,
            fontWeight: FontWeight.bold,
            color: fff_colors.black,
          ),
          title: const TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.normal,
            color: fff_colors.black,
          ),
          subhead: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: fff_colors.black,
          ),
          body2: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
          body1: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.normal,
          ),
          caption: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.normal,
            color: fff_colors.darkGray,
          ),
          button: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
      // Since we don't have animations between view widgets yet, to test, just switch this line out.
      home: Home(),
      // home: AddFriendsSignup(),
      // home: FriendRequests(),
    );
  }
}

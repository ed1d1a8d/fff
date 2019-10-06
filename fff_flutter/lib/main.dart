import 'package:flutter/material.dart';
import 'views/add_friends_signup.dart';
import 'views/home.dart';

void main() => runApp(FFFApp());

class FFFApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // Define the default font family.
        fontFamily: 'Source Sans Pro',

        // Define the default TextTheme. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: const TextTheme(
          body1: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.normal,
          ),
          button: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
      // Since we don't have animations between view widgets yet, to test, just switch this line out.
      home: Home(),
      // home: AddFriendsSignup(),
    );
  }
}

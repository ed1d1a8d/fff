import 'package:flutter/material.dart';
import 'add-friends-signup.dart';
import 'colors.dart' as Colors;

void main() => runApp(FFF());

class FFF extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return AddFriendsSignup();
    return Column(
      children: <Widget>[
        SizedBox(height: 30, width: 50),
        SizedBox(height: 30, width: 10),
        Text(
          "minutes remaining",
          style: TextStyle(
            fontSize: 16,
          ),
      textDirection: TextDirection.ltr,
        ),
        SizedBox(height: 30, width: 6),
      ],
    );
    /*return const Text(
      'test text',
      textAlign: TextAlign.left,
      style: TextStyle(
        color: Colors.black,
      ),
      textDirection: TextDirection.ltr,
    );*/
  }
}

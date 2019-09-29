import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'colors.dart' as Colors;

class AddFriendsSignup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.background,
      padding: EdgeInsets.all(40.0),
      child: Column(
        children: <Widget>[
          // Introduction text and images
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              'here',
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.black,
              ),
              textDirection: TextDirection.ltr,
            ),
          ),

          // List of friends and search
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              'List of friends and search',
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.black,
              ),
              textDirection: TextDirection.ltr,
            ),
          ),

          // Add friends button
          Container(
            child: CupertinoButton(
              child: Text(
                'Add 1 Selected Friends',
                style: TextStyle(
                  color: Colors.black,
                ),
                textDirection: TextDirection.ltr,
              ),
              onPressed: () {},
              color: Colors.strongBackground,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'colors.dart' as Colors;

class AddFriendsSignup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.background,
      padding: const EdgeInsets.all(40.0),
      child: Column(
        children: <Widget>[
          // Introduction text and images
          Container(
            color: const Color(0xFF00FF00),
            alignment: Alignment.topLeft,
            child: Column(
              children: <Widget>[
                Container(
                  color: const Color(0xFFFFFF00),
                  child: const Text(
                    'test',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    textDirection: TextDirection.ltr,
                  ),
                ),
                const Text(
                  'Introduction text',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  textDirection: TextDirection.ltr,
                ),
              ],
            ),
          ),

          // List of friends and search
          Expanded(
            child: Container(
              color: const Color(0xFFFF0000),
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
          ),

          // Add friends button
          Container(
            color: const Color(0xFF0000FF),
            child: CupertinoButton(
              child: const Text(
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

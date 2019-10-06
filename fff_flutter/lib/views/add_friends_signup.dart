import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../components/gradient_container.dart';
import '../utils/colors.dart' as fff_colors;

class AddFriendsSignup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: fff_colors.background,
      padding: const EdgeInsets.all(35.0),
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
                      color: fff_colors.black,
                    ),
                    textDirection: TextDirection.ltr,
                  ),
                ),
                const Text(
                  'Introduction text',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: fff_colors.black,
                  ),
                  textDirection: TextDirection.ltr,
                ),
              ],
            ),
          ),

          // List of friends and search
          Expanded(
            child: GradientContainer(
              margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 15.0),
              child: Text(
                'test',
                style: Theme.of(context).textTheme.body1,
              ),
            ),
          ),

          // Add friends button
          Container(
            child: CupertinoButton(
              child: Text(
                "Add 2 Selected Friends",
                style: Theme.of(context).textTheme.button,
              ),
              onPressed: () {},
              color: fff_colors.strongBackground,
            ),
          ),
        ],
      ),
    );
  }
}

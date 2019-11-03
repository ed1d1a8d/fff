import "dart:developer";
import "package:flutter/material.dart";

import "package:fff/components/fff_timer_tuner.dart";
import "package:fff/utils/colors.dart" as fff_colors;
import "package:fff/routes.dart" as fff_routes;

class FFFTimerExpired extends StatelessWidget {
  static const String routeName = "/fff-timer-expired";

  static bool mounted = false;

  @override
  Widget build(BuildContext context) {
    final double columnWidth = MediaQuery.of(context).size.width * 0.8;

    return Container(
      color: fff_colors.background,
      child: Column(
        children: <Widget>[
          Spacer(flex: 3),
          Container(
            width: columnWidth,
            child: Text(
              "Your timer has expired!",
              style: Theme.of(context).textTheme.display3,
            ),
          ),
          Spacer(flex: 1),
          Container(
            width: columnWidth,
            child: Text(
              "You will only be visible to friends for eating when you mark yourself as available. Please set how long you want to be available for:",
              style: Theme.of(context).textTheme.body1,
            ),
          ),
          Spacer(flex: 1),
          FFFTimerTuner(false),
          Spacer(flex: 1),
          MaterialButton(
            child: Text(
              "Done",
              style: Theme.of(context).textTheme.button,
            ),
            onPressed: () {
              FFFTimerExpired.mounted = false;

              // just go to the home page
              Navigator.pushReplacementNamed(context, fff_routes.home);
            },
            color: fff_colors.strongBackground,
            padding: const EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 25,
            ),
          ),
          Spacer(flex: 3),
        ],
      ),
    );
  }
}

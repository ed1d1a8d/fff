import "dart:developer";

import "package:fff/backend/auth.dart" as fff_auth;
import "package:fff/routes.dart" as fff_routes;
import "package:fff/utils/colors.dart" as fff_colors;
import "package:fff/utils/spacing.dart" as fff_spacing;
import "package:flutter/material.dart";

class Loading extends StatelessWidget {
  static const String routeName = "/loading";

  @override
  Widget build(BuildContext context) {
    final double columnWidth =
        MediaQuery.of(context).size.width * fff_spacing.loadingWidthRatio;

    fff_auth.loginWithSavedCredentials().then((authSucceeded) {
      if (authSucceeded) {
        log("Succesfully loaded saved credentials");
        Navigator.pushReplacementNamed(context, fff_routes.home);
      } else {
        log("Unable to load saved credentials");
        Navigator.pushReplacementNamed(context, fff_routes.login);
      }
    });

    return Container(
      color: fff_colors.background,
      child: Column(
        children: <Widget>[
          Spacer(flex: 5),
          Container(
            width: columnWidth,
            child: Text(
              "Free\nFor\nFood?",
              style: Theme.of(context).textTheme.display4,
            ),
          ),
          Spacer(flex: 2),
          Image.asset(
            "assets/images/pizza-burger.png",
            width: columnWidth,
          ),
          Spacer(flex: 5),
        ],
      ),
    );
  }
}

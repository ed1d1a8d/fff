import "package:flutter/material.dart";
import "package:fff/utils/spacing.dart" as fff_spacing;
import "package:fff/utils/colors.dart" as fff_colors;

class Loading extends StatelessWidget {
  static const String routeName = "/loading";

  Loading() {
    print("TODO BACKEND");

    // auth and whatever
  }

  @override
  Widget build(BuildContext context) {
    final double columnWidth = MediaQuery.of(context).size.width * fff_spacing.loadingWidthRatio;

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
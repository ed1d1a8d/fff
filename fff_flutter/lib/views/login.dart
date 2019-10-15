import "package:flutter/material.dart";
import "package:fff/utils/spacing.dart" as fff_spacing;
import "package:fff/utils/colors.dart" as fff_colors;

class Login extends StatelessWidget {
  static const String routeName = "/login";

  @override
  Widget build(BuildContext context) {
    const double buttonHeight = 60;
    const EdgeInsetsGeometry buttonPadding = const EdgeInsets.symmetric(
      horizontal: 20,
    );
    final double columnWidth =
        MediaQuery.of(context).size.width * fff_spacing.loadingWidthRatio;

    return Container(
      color: fff_colors.background,
      child: Align(
        alignment: Alignment.center,
        child: Container(
          width: columnWidth,
          alignment: Alignment.center,
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
              Spacer(flex: 3),
              Image.asset(
                "assets/images/pizza-burger.png",
              ),
              Spacer(flex: 2),
              Text(
                "Find friends who also want to eat!",
                style: Theme.of(context).textTheme.display3,
                textAlign: TextAlign.center,
              ),
              Spacer(flex: 3),
              MaterialButton(
                height: buttonHeight,
                color: fff_colors.fb,
                onPressed: () {
                  print("TODO BACKEND");

                  // launch fb auth
                },
                padding: buttonPadding,
                child: Row(
                  children: <Widget>[
                    Image.asset(
                      "assets/images/fb-logo.png",
                      height: buttonHeight / 2,
                    ),
                    Spacer(),
                    Text(
                      "Login with Facebook",
                      style: Theme.of(context)
                          .textTheme
                          .body2
                          .apply(color: fff_colors.white),
                      textAlign: TextAlign.center,
                    ),
                    Spacer(),
                  ],
                ),
              ),
              Spacer(flex: 1),
              MaterialButton(
                height: buttonHeight,
                disabledColor: fff_colors.white,
                onPressed: null,
                padding: buttonPadding,
                child: Text(
                  "Other registration methods coming soon!",
                  style: Theme.of(context).textTheme.body2,
                  textAlign: TextAlign.center,
                ),
              ),
              Spacer(flex: 5),
            ],
          ),
        ),
      ),
    );
  }
}
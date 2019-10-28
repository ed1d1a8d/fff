import 'package:fff/backend/auth.dart' as fff_auth;
import 'package:fff/routes.dart' as fff_routes;
import "package:fff/utils/colors.dart" as fff_colors;
import "package:fff/utils/spacing.dart" as fff_spacing;
import "package:fff/models/user_data.dart";
import "package:flutter/material.dart";
import 'package:fff/backend/lobby.dart';
import "package:http/http.dart" as http;
import "package:fff/backend/constants.dart";
import "dart:convert";

UserData me;

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
                onPressed: () async {
                  if (await fff_auth.loginWithFacebook()) {
                    print("Authentication succeeded!");

                    final response = await http.get(server_location + "/api/self.json",
                        headers: fff_auth.getAuthHeaders());

//                    print(response);

//                    final addingFBIDToBackend = await http.put(
//                      server_location + "/api/self.json",
//                      body: {"facebook_ID": "test"},
//                    );
//
//                    final myProfileData = await http.get(
//                        'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${token}');
//                    final profile = JSON.decode(graphResponse.body);

                    print (response.body);

                    me = UserData.fromJson(json.decode(response.body));

                    Navigator.pushReplacementNamed(context, fff_routes.home);
                  } else {
                    print("Authentication failed!");
                    // TODO: Notify user that authentication failed for whatever reason.
                  }
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

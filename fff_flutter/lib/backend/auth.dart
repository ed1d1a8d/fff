import "dart:convert";
import "dart:developer";

import "package:fff/backend/constants.dart" as fff_backend_constants;
import "package:fff/backend/push_notifications.dart" as fff_push_notifications;
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import "package:http/http.dart" as http;
import "package:shared_preferences/shared_preferences.dart";

const String authEndpoint = fff_backend_constants.server_location + "/auth/";

const String _savedAuthTokenKey = "fff_authToken";
String _authToken; // fff

final facebookLogin = FacebookLogin();

bool isAuthenticated() => _authToken != null;

String accessToken; // facebook

/// Tries to login with credentials from persistent storage
/// Returns true if successful
Future<bool> loginWithSavedCredentials() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  final String savedToken = prefs.getString(_savedAuthTokenKey);
  if (savedToken == null) return false;

  // validate authtoken with backend
  bool isValid;
  await http.get(
    fff_backend_constants.server_location + "/api/dumb/",
    headers: {"Authorization": "Token $savedToken"},
  ).then((http.Response response) {
    log("Accessing authenticated dumb endpoint with saved auth token... " +
        response.statusCode.toString());
    isValid = response.statusCode == 200;
  }).catchError((_) {
    isValid = false;
  });
  if (!isValid) return false;

  _authToken = savedToken;
  await fff_push_notifications.subscribe();
  return true;
}

/// Returns true if login succeeded.
Future<bool> loginWithFacebook() async {
  final fbLoginResult = await facebookLogin.logIn(["user_friends"]);
  accessToken = fbLoginResult.accessToken.token;

  switch (fbLoginResult.status) {
    case FacebookLoginStatus.cancelledByUser:
    case FacebookLoginStatus.error:
      return false;
    case FacebookLoginStatus.loggedIn:
      break;
  }

  // Get FFF auth token with FB access token
  final response = await http.post(
    fff_backend_constants.server_location + "/auth/facebook/",
    body: {"access_token": fbLoginResult.accessToken.token},
  );
  _authToken = json.decode(response.body)["key"];

  // Optionally generate mock data for user.
  if (fff_backend_constants.remoteMockData) {
    log("Requesting backend mock data generation for user...");
    log("User auth token: $_authToken");
    await http.post(
        fff_backend_constants.server_location +
            "/api/mockdata/generate_for_user/",
        headers: getAuthHeaders());
  }

  // Save credentials to persistent storage
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(_savedAuthTokenKey, _authToken);

  await fff_push_notifications.subscribe();

  return true;
}

Future<void> logout() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove(_savedAuthTokenKey);

  await fff_push_notifications.unsubscribe();

  _authToken = null;
}

Map<String, String> getAuthHeaders() {
  if (_authToken == null) {
    throw new StateError(
        "Should not call getAuthHeaders when not authenticated.");
  }
  return {"Authorization": "Token $_authToken"};
}

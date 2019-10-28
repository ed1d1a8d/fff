import "dart:convert";

import "package:fff/backend/constants.dart" as fff_backend_constants;
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import "package:http/http.dart" as http;

/// Contains functions that handle registration and authentication.
import 'package:shared_preferences/shared_preferences.dart';

const String savedAuthTokenKey = "fff_authToken";

final facebookLogin = FacebookLogin();
String _authToken;

bool isAuthenticated() => _authToken != null;

/// Tries to retrieve credentials from persistent storage
/// Returns true if successful
Future<bool> loginWithSavedCredentials() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  final String savedToken = prefs.getString(savedAuthTokenKey);
  if (savedToken == null) return false;

  // TODO: Validate savedToken with backend.
  // TODO: Handle offline case.

  _authToken = savedToken;
  return true;
}

/// Returns true if authentication succeeded.
Future<bool> loginWithFacebook() async {
  final fbLoginResult = await facebookLogin.logIn(["user_friends"]);

  switch (fbLoginResult.status) {
    case FacebookLoginStatus.cancelledByUser:
    case FacebookLoginStatus.error:
      return false;
    case FacebookLoginStatus.loggedIn:
      break;
  }

  // get FFF auth token with FB access token
  // code is self-explanatory
  final response = await http.post(
    fff_backend_constants.server_location + "/auth/facebook/",
    body: {"access_token": fbLoginResult.accessToken.token},
  );
  _authToken = json.decode(response.body)["key"];

  if (fff_backend_constants.remoteMockData) {
    await http.post(
        fff_backend_constants.server_location +
            "/api/mockdata/generate_for_user/",
        headers: getAuthHeaders());
    print("Auth token: $_authToken");
  }

  // otherwise, use a hardcoded token here
  // _authToken = "ceb1cf031743b5f44adf210941713119c0ba7dc4";

  // Save credentials to persistent storage
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(savedAuthTokenKey, _authToken);

  return true;
}

Future<void> logout() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove(savedAuthTokenKey);
  _authToken = null;
}

Map<String, String> getAuthHeaders() {
  if (_authToken == null) {
    throw new StateError(
        "Should not call getAuthHeaders when not authenticated.");
  }
  return {"Authorization": "Token $_authToken"};
}

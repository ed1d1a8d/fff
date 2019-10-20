import 'package:flutter_facebook_login/flutter_facebook_login.dart';

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

  // TODO: get authToken from fff_backend using fbLoginResult.accessToken
  _authToken = "fa7c05bff3f4a6cbf221264b19b27840b73b2d8a";

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

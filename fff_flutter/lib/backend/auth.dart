/// Contains functions that handle registration and authentication.

import 'package:flutter_facebook_login/flutter_facebook_login.dart';

final facebookLogin = FacebookLogin();
String _authToken;

/// Tries to retrieve credentials from persistent storage
/// Returns true if succesful
Future<bool> authenticateWithStored () async {
  // TODO: Attempt to get credentials using shared_preferences
  return false;
}

/// Returns true if authentication succeeded.
Future<bool> authenticateWithFacebook() async {
  final fbLoginResult = await facebookLogin.logIn(["user_friends"]);

  switch (fbLoginResult.status) {
    case FacebookLoginStatus.cancelledByUser:
    case FacebookLoginStatus.error:
      return false;
    case FacebookLoginStatus.loggedIn:
      break;
  }

  // TODO: Authenticate with fff_backend
  _authToken = "dfde53379d7316eeb8cc35d9064462974e5ca50a";
  return true;
}

Map<String, String> getAuthHeaders() {
  if (_authToken == null) {
    throw new Exception("Can't get auth headers when not authenticated.");
  }
  return {"Authorization": "Token $_authToken"};
}

/*
Procedures related to the FFF timer backend.
*/

import "dart:convert";
import "dart:developer";

import "package:fff/backend/auth.dart" as fff_auth;
import "package:fff/backend/constants.dart" as fff_backend_constants;
import "package:http/http.dart" as http;

const String endpoint =
    fff_backend_constants.server_location + "/api/lobby/expiration/";
const String expirationTimeField = "lobby_expiration";

DateTime _expirationTime;

Future<void> fetchExpirationTime() async {
  final response = await http.get(endpoint, headers: fff_auth.getAuthHeaders());
  log("fetch response: " + response.body.toString());
  final Map<String, dynamic> lobbyExpirationMap = json.decode(response.body);
  final String expirationString = lobbyExpirationMap[expirationTimeField];
  _expirationTime = DateTime.parse(expirationString);
  log("Fetched expiration time of $_expirationTime");
}

Future<bool> setExpirationTime(DateTime newExpirationTime) async {
  log("Setting new lobby expiration time on backend: ${newExpirationTime.toUtc()}.");
  final response = await http.post(
    endpoint,
    headers: fff_auth.getAuthHeaders(),
    body: {expirationTimeField: newExpirationTime.toUtc().toString()},
  );

  if (response.statusCode == 200) {
    _expirationTime = newExpirationTime;
    return true;
  }
  return false;
}

/// needs to be called after fetchExpirationTime
bool hasExpired() {
  if (_expirationTime == null) {
    throw new StateError(
        "Should not call hasExpired before calling fetch or set.");
  }

  return _expirationTime.isBefore(DateTime.now());
}

/// needs to be called after fetchExpirationTime
Duration getRemainingDuration() {
  if (_expirationTime == null) {
    throw new StateError(
        "Should not call hasExpired before calling fetch or set.");
  }

  final Duration diff = _expirationTime.difference(DateTime.now());
  return diff > Duration.zero ? diff : Duration.zero;
}

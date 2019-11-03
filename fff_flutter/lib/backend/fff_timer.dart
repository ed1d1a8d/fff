/*
Procedures related to the FFF timer backend.
*/

import "dart:convert";
import "dart:developer";

import "package:fff/backend/constants.dart" as fff_backend_constants;
import "package:fff/backend/auth.dart" as fff_auth;
import "package:http/http.dart" as http;

const String endpoint =
    fff_backend_constants.server_location + "/api/lobby/expiration/";
const String expirationTimeField = "lobby_expiration";

Future<DateTime> getExpirationTime() async {
  final http.Response response =
      await http.get(endpoint, headers: fff_auth.getAuthHeaders());
  final Map<String, dynamic> lobbyExpirationMap =
      json.decode(response.body);
  final String expirationString = lobbyExpirationMap[expirationTimeField];
  log("Lobby expiration retrieved from backend: " + expirationString);
  return DateTime.parse(expirationString);
}

Future<http.Response> setExpirationTime(DateTime newExpirationTime) async {
  log("Set new lobby expiration time on backend: " + newExpirationTime.toUtc().toString() + ".");
  return await http.post(
    endpoint,
    headers: fff_auth.getAuthHeaders(),
    body: { expirationTimeField: newExpirationTime.toUtc().toString() },
  );
}

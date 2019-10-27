import 'dart:convert';

import "package:fff/backend/auth.dart" as fff_auth;
import "package:fff/backend/constants.dart" as fff_backend_constants;
import "package:firebase_messaging/firebase_messaging.dart";
import "package:http/http.dart" as http;

const String selfEndpoint =
    fff_backend_constants.server_location + "/api/self/";

updateFcmToken() async {
  final String fcmToken = await FirebaseMessaging().getToken();
  if (fcmToken == null) throw new Exception("Failed to get fcm token");

  final response = await http.put("$selfEndpoint/detail/",
      body: jsonEncode({"fcm_token": fcmToken}),
      headers: fff_auth.getAuthHeaders());
  if (response.statusCode != 200)
    throw new Exception("Failed to update fcm token");
}

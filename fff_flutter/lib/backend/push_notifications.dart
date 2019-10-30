import "dart:developer";
import "dart:io";

import "package:fff/backend/auth.dart" as fff_auth;
import "package:fff/backend/constants.dart" as fff_backend_constants;
import "package:firebase_messaging/firebase_messaging.dart";
import "package:http/http.dart" as http;

const String push_notification_endpoint =
    fff_backend_constants.server_location + "/api/self/device";

Future<void> subscribe() async {
  final String fcmToken = await FirebaseMessaging().getToken();
  if (fcmToken == null) return;

  final response = await http.put("$push_notification_endpoint/$fcmToken/",
      headers: fff_auth.getAuthHeaders());
  if (response.statusCode == HttpStatus.created) {
    log("Subscribed to push notifications.");
  } else {
    log("Failed to subscribe to push notifications. Status code: ${response.statusCode}");
  }
}

Future<void> unsubscribe() async {
  final String fcmToken = await FirebaseMessaging().getToken();
  if (fcmToken == null) return;

  final response = await http.delete("$push_notification_endpoint/$fcmToken/",
      headers: fff_auth.getAuthHeaders());
  if (response.statusCode == HttpStatus.ok) {
    log("Unsubscribed to push notifications.");
  } else {
    log("Failed to unsubscribe to push notifications. Status code: ${response.statusCode}");
  }
}

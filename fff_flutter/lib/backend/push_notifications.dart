import "package:fff/backend/auth.dart" as fff_auth;
import "package:fff/backend/constants.dart" as fff_backend_constants;
import "package:firebase_messaging/firebase_messaging.dart";
import "package:http/http.dart" as http;

const String push_notification_endpoint =
    fff_backend_constants.server_location + "/self/device";

Future<void> subscribe() async {
  final String fcmToken = await FirebaseMessaging().getToken();
  if (fcmToken == null) return;

  await http.put(push_notification_endpoint + "/$fcmToken/",
      headers: fff_auth.getAuthHeaders());
}

Future<void> unsubscribe() async {
  final String fcmToken = await FirebaseMessaging().getToken();
  if (fcmToken == null) return;

  await http.delete(push_notification_endpoint + "/$fcmToken/",
      headers: fff_auth.getAuthHeaders());
}

import "package:fff/backend/auth.dart" as fff_auth;
import "package:fff/backend/constants.dart" as fff_backend_constants;
import "package:fff/backend/auth.dart" as fff_auth;
import "package:fff/backend/constants.dart" as fff_backend_constants;
import "package:fff/models/user_data.dart";
import 'package:fff/models/mock_data.dart';
import "package:http/http.dart" as http;


Future<List<UserData>> fetchFBFriends() async {
  if (fff_backend_constants.localMockData) {
    return MockData.onlineFriends;
  }

  final response = await http.get(fff_backend_constants.server_location + "/fbfriends.json",
      headers: fff_auth.getAuthHeaders());

  if (response.statusCode != 200)
    throw new Exception("Failed to get FB Friends friends...");

  return UserData.listFromJsonString(response.body);
}
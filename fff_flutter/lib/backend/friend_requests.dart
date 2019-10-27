import "package:fff/backend/auth.dart" as fff_auth;
import "package:fff/backend/constants.dart" as fff_backend_constants;
import "package:fff/models/user_data.dart";
import "package:http/http.dart" as http;

Future<List<UserData>> fetchUnrejectedRequests() async {
  const String endpoint = fff_backend_constants.server_location +
      "/api/friends/requests/unrejected/";
  final response = await http.get(endpoint, headers: fff_auth.getAuthHeaders());

  if (response.statusCode != 200)
    throw new Exception("FAILURE: Could not fetch unrejected requests.");
  print(response.body);

  // return UserData.listFromJsonString(response.body);
  return null; // not finished
}

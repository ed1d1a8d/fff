import "package:fff/backend/auth.dart" as fff_auth;
import "package:fff/backend/constants.dart" as fff_backend_constants;
import 'package:fff/models/ffrequest.dart';
import 'package:fff/models/mock_data.dart';
import "package:fff/models/user_data.dart";
import "package:http/http.dart" as http;

final String lobbyEndpoint =
    fff_backend_constants.server_location + "/api/lobby";

Future<List<UserData>> fetchOnlineFriends() async {
  if (fff_backend_constants.mockData) {
    return MockData.onlineFriends;
  }

  final response = await http.get(lobbyEndpoint + "/friends.json",
      headers: fff_auth.getAuthHeaders());

  if (response.statusCode != 200)
    throw new Exception("Failed to get lobby friends...");

  return UserData.listFromJsonString(response.body);
}

Future<List<FFRequest>> fetchIncomingRequests() async {
  if (fff_backend_constants.mockData) {
    return MockData.incomingRequests;
  }
}

Future<List<FFRequest>> fetchOutgoingRequests() async {
  if (fff_backend_constants.mockData) {
    return MockData.outgoingRequests;
  }
}
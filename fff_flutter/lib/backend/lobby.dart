import "package:fff/backend/auth.dart" as fff_auth;
import "package:fff/backend/constants.dart" as fff_backend_constants;
import "package:fff/models/ffrequest.dart";
import "package:fff/models/mock_data.dart";
import "package:fff/models/user_data.dart";
import "package:http/http.dart" as http;
import "dart:developer";

const String lobbyEndpoint =
    fff_backend_constants.server_location + "/api/lobby";

final String ffrequestsEndpoint =
    fff_backend_constants.server_location + "/api/ffrequests";

Future<List<UserData>> fetchOnlineFriends() async {
  if (fff_backend_constants.localMockData) {
    return MockData.onlineFriends;
  }

  final response = await http.get(lobbyEndpoint + "/friends.json",
      headers: fff_auth.getAuthHeaders());

  if (response.statusCode != 200)
    throw new Exception("Failed to get lobby friends: $response.statusCode .");

  return UserData.listFromJsonString(response.body);
}

Future<List<FFRequest>> fetchIncomingRequests() async {
  if (fff_backend_constants.localMockData) {
    return MockData.incomingRequests;
  }

  final response = await http.get(ffrequestsEndpoint + "/incoming/pending.json",
      headers: fff_auth.getAuthHeaders());

  if (response.statusCode != 200)
    throw new Exception(
        "Failed to get incoming requests: $response.statusCode .");

  // second argument set to true because it IS an INCOMING request
  return FFRequest.listFromJsonString(response.body, true);
}

Future<List<FFRequest>> fetchOutgoingRequests() async {
  if (fff_backend_constants.localMockData) {
    return MockData.outgoingRequests;
  }

  final response = await http.get(ffrequestsEndpoint + "/outgoing/pending.json",
      headers: fff_auth.getAuthHeaders());

  if (response.statusCode != 200)
    throw new Exception(
        "Failed to get outgoing requests: $response.statusCode .");

  // second argument set to false because it is NOT an INCOMING request
  return FFRequest.listFromJsonString(response.body, false);
}

Future<List<FFRequest>> fetchUnreadAcceptedFFRequests() async {
  final response = await http.get(ffrequestsEndpoint + "/accepted_and_unread/",
      headers: fff_auth.getAuthHeaders());

  if (response.statusCode != 200)
    throw new Exception("Failed to fetch unread requests: " +
        response.statusCode.toString() +
        ".");

  // unread is, by definition, an outgoing request
  return FFRequest.listFromJsonString(response.body, false);
}

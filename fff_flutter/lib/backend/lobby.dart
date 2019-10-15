import "package:fff/backend/auth.dart" as fff_auth;
import "package:fff/backend/server_location.dart";
import "package:fff/models/user_data.dart";
import "package:http/http.dart" as http;

final String lobbyEndpoint = server_location + "/api/lobby";

Future<List<UserData>> fetchLobbyFriends() async {
  final response = await http.get(lobbyEndpoint + "/friends.json",
      headers: fff_auth.getAuthHeaders());

  if (response.statusCode != 200)
    throw new Exception("Failed to get lobby friends...");

  return UserData.listFromJsonString(response.body);
}

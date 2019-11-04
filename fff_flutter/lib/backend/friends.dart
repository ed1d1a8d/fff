import "dart:developer";

import "package:fff/backend/auth.dart" as fff_auth;
import "package:fff/backend/constants.dart" as fff_backend_constants;
import "package:fff/models/friend_request.dart";
import 'package:fff/models/mock_data.dart';
import "package:fff/models/user_data.dart";
import "package:http/http.dart" as http;

final String _friendsEndpoint =
    fff_backend_constants.server_location + "/api/friends";

Future<List<UserData>> fetchFriends() async {
  final response = await http.get("$_friendsEndpoint/friends.json",
      headers: fff_auth.getAuthHeaders());

  if (response.statusCode != 200)
    throw new Exception("Could not fetch friends");

  return UserData.listFromJsonString(response.body);
}

Future<List<UserData>> fetchNonFriends() async {
  final response = await http.get("$_friendsEndpoint/nonfriends.json",
      headers: fff_auth.getAuthHeaders());

  if (response.statusCode != 200)
    throw new Exception("Could not fetch nonfriends");

  return UserData.listFromJsonString(response.body);
}

Future<bool> createRequest(UserData toUser) async {
  final response = await http.post(
      "$_friendsEndpoint/actions/request/${toUser.id}/",
      headers: fff_auth.getAuthHeaders());

  if (response.statusCode != 200) log("Failed to send friend request.");

  return response.statusCode == 200;
}

Future<List<FriendRequest>> fetchIncomingRequests() async {
  final response = await http.get("$_friendsEndpoint/requests/incoming/",
      headers: fff_auth.getAuthHeaders());

  if (response.statusCode != 200)
    throw new Exception("Could not fetch incoming friend requests.");

  return FriendRequest.listFromJsonString(response.body);
}

Future<List<FriendRequest>> fetchOutgoingRequests() async {
  final response = await http.get("$_friendsEndpoint/requests/outgoing/",
      headers: fff_auth.getAuthHeaders());

  if (response.statusCode != 200)
    throw new Exception("Could not fetch outgoing friend requests.");

  return FriendRequest.listFromJsonString(response.body);
}

Future<bool> acceptRequest(FriendRequest fr) async {
  final response = await http.post(
      "$_friendsEndpoint/actions/accept/${fr.fromUser.id}/",
      headers: fff_auth.getAuthHeaders());

  if (response.statusCode != 200) log("Failed to accept friend request.");

  return response.statusCode == 200;
}

Future<bool> declineRequest(FriendRequest fr) async {
  final response = await http.post(
      "$_friendsEndpoint/actions/decline/${fr.fromUser.id}/",
      headers: fff_auth.getAuthHeaders());

  if (response.statusCode != 200) log("Failed to decline friend request.");

  return response.statusCode == 200;
}

Future<List<UserData>> fetchFBFriends() async {
  if (fff_backend_constants.localMockData) {
    return MockData.onlineFriends;
  }

  final response = await http.get("$_friendsEndpoint/fbfriends.json",
      headers: fff_auth.getAuthHeaders());

  if (response.statusCode != 200)
    throw new Exception("Failed to get FB Friends friends...");

  return UserData.listFromJsonString(response.body);
}

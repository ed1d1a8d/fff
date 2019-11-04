import "dart:convert";

import "package:fff/models/user_data.dart";

class FriendRequest {
  final int id;
  final UserData fromUser;
  final UserData toUser;

  FriendRequest({
    this.id,
    this.fromUser,
    this.toUser,
  });

  // Everything returned will be appropriate based on
  factory FriendRequest.fromJson(Map<String, dynamic> json) => FriendRequest(
        id: json["id"],
        fromUser: UserData.fromJson(json["from_user"]),
        toUser: UserData.fromJson(json["to_user"]),
      );

  static List<FriendRequest> listFromJsonString(String str) =>
      List<FriendRequest>.from(
          json.decode(str).map((x) => FriendRequest.fromJson(x)));
}

import "package:fff/models/user_data.dart";

class FFRequest {
  final UserData user;
  final String message;
  final bool isIncoming;

  FFRequest({
    this.user,
    this.message,
    this.isIncoming,
  });

  // Everything returned will be appropriate based on
  factory FFRequest.fromJson(Map<String, dynamic> json, bool isIncoming) {
    if (isIncoming) {
      return FFRequest(
          user: UserData.fromJson(json["user"]),
          message: json["sender"]
      );
    }
    else {
      return FFRequest(
          user: UserData.fromJson(json["user"]),
          message: json["receiver"]
      );
    }
  }

//  factory FFRequest.fromJsonString(String str) =>
//      FFRequest.fromJson(json.decode(str));

}

import "package:fff/models/user_data.dart";
import 'dart:convert';

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
          user: UserData.fromJson(json["sender"]),
          message: json["message"],
          isIncoming: true,
      );
    }
    else {
      return FFRequest(
          user: UserData.fromJson(json["receiver"]),
          message: json["message"],
          isIncoming: false,
      );
    }
  }

  static List<FFRequest> listFromJsonString(String str, bool isIncoming) {
    return List<FFRequest>.from(
        json.decode(str).map((x) =>
            FFRequest.fromJson(x, isIncoming)));
  }

}

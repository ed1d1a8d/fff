import "package:fff/models/user_data.dart";
import 'dart:convert';

class FFRequest {
  final int id;
  final UserData user;
  final String message;
  final bool isIncoming;

  FFRequest({
    this.id,
    this.user,
    this.message,
    this.isIncoming,
  });

  // Everything returned will be appropriate based on
  factory FFRequest.fromJson(Map<String, dynamic> json, bool isIncoming) {
    if (isIncoming) {
      return FFRequest(
        id: json["id"],
        user: UserData.fromJson(json["sender"]),
        message: json["message"],
        isIncoming: true,
      );
    } else {
      return FFRequest(
        id: json["id"],
        user: UserData.fromJson(json["receiver"]),
        message: json["message"],
        isIncoming: false,
      );
    }
  }

  static FFRequest fromJsonString(String str, bool isIncoming) {
    return FFRequest.fromJson(json.decode(str), isIncoming);
  }

  static List<FFRequest> listFromJsonString(String str, bool isIncoming) {
    return List<FFRequest>.from(
        json.decode(str).map((x) => FFRequest.fromJson(x, isIncoming)));
  }
}

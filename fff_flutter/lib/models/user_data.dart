import 'dart:convert';

class UserData {
  final int id;
  final String username;
  final String name;
  final String facebookId;
  final String imageUrl;
  final double latitude;
  final double longitude;

  final String message;
  final String lastFoodDate;

  double distance;

  UserData({
    this.id,
    this.username,
    this.name,
    this.facebookId,
    this.imageUrl,
    this.latitude,
    this.longitude,
    this.message,
    this.lastFoodDate,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        id: json["id"],
        username: json["username"],
        name: json["name"],
        facebookId: json["facebook_id"],
        imageUrl: json["image_url"],
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
      );

  factory UserData.fromJsonString(String str) =>
      UserData.fromJson(json.decode(str));

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "name": name,
        "facebook_id": facebookId,
        "image_url": imageUrl,
        "latitude": latitude,
        "longitude": longitude,
      };

  String toJsonString() => json.encode(toJson());

  static List<UserData> listFromJsonString(String str) =>
      List<UserData>.from(json.decode(str).map((x) => UserData.fromJson(x)));

}

class SimpleUserData {
  final String name;
  final int facebookId;
  String imageUrl;

  SimpleUserData({
    this.name,
    this.facebookId
  });

  factory SimpleUserData.fromJson(Map<String, dynamic> json) => SimpleUserData(
    name: json["name"],
    facebookId: int.parse(json["id"]),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "facebook_id": facebookId,
  };

  String toJsonString() => json.encode(toJson());

  static List<SimpleUserData> listFromJsonString(String str) =>
      List<SimpleUserData>.from(json.decode(str).map((x) => SimpleUserData.fromJson(x)));

}
class UserData {
  final int id;
  final String facebookId;
  final String username;

  final String name;
  final String imageURL;

  final double latitude;
  final double longitude;

  const UserData(
      {this.id,
      this.facebookId,
      this.username,
      this.name,
      this.imageURL,
      this.latitude,
      this.longitude});

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'],
      facebookId: json['facebook_id'],
      username: json['username'],
      name: json['name'],
      imageURL: json['imageURL'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}

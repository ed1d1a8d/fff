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

}

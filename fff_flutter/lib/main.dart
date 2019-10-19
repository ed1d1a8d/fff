import 'package:fff/routes.dart' as fff_routes;
import "package:fff/utils/theme.dart";
import "package:fff/views/add_friends_signup.dart";
import 'package:fff/views/friend_detail.dart';
import 'package:fff/views/search_people.dart';
import "package:fff/views/friend_requests.dart";
import "package:fff/views/home.dart";
import "package:fff/views/loading.dart";
import "package:fff/views/login.dart";
import "package:flutter/material.dart";
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() => runApp(FFFApp());

class FFFApp extends StatelessWidget {

  GoogleMapController mapController;

  final LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,

      // Switch this line out for easier debugging
//      home: Loading(),
      // home: Login(),
//       home: AddFriendsSignup(),
       home: Home(),
//       home: SearchPeople(),

      // Used by the navigator.
      routes: <String, WidgetBuilder>{
        fff_routes.loading: (BuildContext context) => Loading(),
        fff_routes.login: (BuildContext context) => Login(),
        fff_routes.home: (BuildContext context) => Home(),
        fff_routes.friendRequest: (BuildContext context) => FriendRequests(),
        fff_routes.addFriendSignup: (BuildContext context) =>
            AddFriendsSignup(),
        fff_routes.searchPeople: (BuildContext context) => SearchPeople(),
      },
    );
  }
}

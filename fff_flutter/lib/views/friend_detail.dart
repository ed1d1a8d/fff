import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import "package:fff/utils/colors.dart" as fff_colors;
import "package:fff/models/mock_data.dart";
import "package:fff/components/url_avatar.dart";

class FriendDetail extends StatefulWidget {
  static const String routeName = 'friend-detail';

  final int friendIndex;

  FriendDetail(this.friendIndex, {Key key}) : super(key: key);

  @override
  _FriendDetailState createState() => _FriendDetailState();
}

class _FriendDetailState extends State<FriendDetail> {

  GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    String friendImg = MockData.imageURLs[widget.friendIndex];
    String friendName = MockData.names[widget.friendIndex];
    LatLng friendCenter = LatLng(45.521563, -122.677433);

    return Scaffold(
      backgroundColor: fff_colors.background,
      appBar: AppBar(
        textTheme: Theme.of(context).textTheme.apply(
          bodyColor: Colors.black,
          displayColor: Colors.black
        ),
        iconTheme: IconThemeData(
          color: Colors.black
        ),
        backgroundColor: fff_colors.navBarBackground,
        titleSpacing: -5.0,
        title: Container(
          child: Row(
            children: <Widget>[
              URLAvatar(imageURL: friendImg),
              SizedBox(width: 10),
              Text(friendName)
            ],
          ),
        ),

      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Container(
          constraints: BoxConstraints.expand(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _mapWidget(context, friendCenter),
              Text("Last Time You Got Food Integration"),
              Text("Ask To Get Food"),
            ],
          )
        )
      ),
    );
  }

  Widget _mapWidget(BuildContext context, LatLng center) {
//    Marker currMarker = Marker(position: center);
    Marker friendMarker = Marker(markerId: MarkerId("0"), position: center);
    Set<Marker> elements = [friendMarker].toSet();

    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      child: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: center,
          zoom: 11.0,
        ),
        markers: elements
      )
    );
  }

}
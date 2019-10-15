import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    String friend_img = MockData.imageURLs[widget.friendIndex];
    String friend_name = MockData.names[widget.friendIndex];

    return Scaffold(
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
              URLAvatar(imageURL: friend_img),
              SizedBox(width: 10),
              Text(friend_name)
            ],
          ),
        ),

      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Container(
          color: fff_colors.background,
          constraints: BoxConstraints.expand(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text("Google Maps Integration"),
              Text("Last Time You Got Food Integration"),
              Text("Ask To Get Food"),
            ],
          )
        )
      ),
    );
  }

}
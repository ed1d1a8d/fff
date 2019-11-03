import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";

import "package:google_maps_flutter/google_maps_flutter.dart";

import "package:fff/backend/ffrequests.dart" as fff_request_backend;
import "package:fff/utils/colors.dart" as fff_colors;
import "package:fff/utils/spacing.dart" as fff_spacing;
import "package:fff/views/home.dart";
import "package:fff/components/Dialog.dart";
import "package:fff/models/ffrequest.dart";
import "package:fff/models/user_data.dart";
import "package:fff/components/url_avatar.dart";
import "package:fff/components/gradient_container.dart";

class FriendDetail extends StatefulWidget {
  static const String routeName = "friend-detail";
  final UserData user;
  final FFRequest ffRequest;
  final Function callback;
  final bool isAccepted; // if this is true, then show the accepted screen

  FriendDetail(
    this.user,
    this.ffRequest,
    this.callback, {
    Key key,
    isAccepted,
  })  : this.isAccepted = isAccepted == true,
        super(key: key);

  @override
  _FriendDetailState createState() => _FriendDetailState();
}

class _FriendDetailState extends State<FriendDetail> {
  GoogleMapController mapController;

  // what the user might type as a request to send to the other user
  String newRequestMessage = "";

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    String friendName = widget.user.name;
    LatLng friendCenter = LatLng(widget.user.latitude, widget.user.longitude);
    String date = widget.user.lastFoodDate;
    String lastFFF = date == null
        ? "You have never eaten with $friendName."
        : "The last time you ate with $friendName was on $date.";

    // if the ff request is accepted, then build a different view
    List<Widget> widgets = [_mapWidget(context, friendCenter)];

    if (widget.isAccepted) {
      widgets.addAll([
        Spacer(flex: 3),
        Container(
          child: Text(
            friendName + " and you are getting food together!",
            style: Theme.of(context).textTheme.display3,
            textAlign: TextAlign.center,
          ),
        ),
        Spacer(flex: 2),
        MaterialButton(
          child: Text(
            "Message " + friendName,
            style: Theme.of(context).textTheme.button,
          ),
          onPressed: () {
            print("TODO");
          },
          color: fff_colors.strongBackground,
          padding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 25,
          ),
        ),
        Spacer(flex: 2),
        Container(
          child: Text(
            "Have a good meal!",
            style: Theme.of(context).textTheme.headline,
          ),
        ),
        Spacer(flex: 1),
        Container(
          child: Text(
            "Your timer has been set to 0.\nTime to leave the app and grab food!",
            style: Theme.of(context).textTheme.body1,
            textAlign: TextAlign.center,
          ),
        ),
        Spacer(flex: 2),
        Image.asset(
          "assets/images/pizza-burger.png",
          width: MediaQuery.of(context).size.width * 0.5,
        ),
        Spacer(flex: 3),
      ]);
    } else {
      widgets.addAll([
        SizedBox(height: fff_spacing.profileListInsets),
        Container(
          // expand to fill the width of the outside container to left align the text inside
          constraints:
              BoxConstraints.tightFor(width: MediaQuery.of(context).size.width),
          child: Text(
            lastFFF,
            style: Theme.of(context).textTheme.body2,
          ),
        ),
        SizedBox(height: fff_spacing.profileListInsets),
        Expanded(
          child: GradientContainer(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: this._buildTextField(),
                ),
                Divider(
                  color: fff_colors.black,
                ),
                Container(
                  child: Row(children: this._buildActionRow()),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: fff_spacing.profileListInsets),
        Image.asset(
          "assets/images/pizza-burger.png",
          height: MediaQuery.of(context).size.height * 0.1,
        ),
      ]);
    }

    return Scaffold(
      resizeToAvoidBottomInset: false, // don't resize when keyboard up
      backgroundColor: fff_colors.background,
      appBar: AppBar(
        brightness: Brightness.light,
        textTheme: Theme.of(context)
            .textTheme
            .apply(bodyColor: Colors.black, displayColor: Colors.black),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: fff_colors.navBarBackground,
        titleSpacing: -5.0,
        title: Container(
          child: Row(
            children: <Widget>[
              URLAvatar(imageURL: widget.user.imageUrl),
              SizedBox(width: fff_spacing.profileListInsets),
              Text(friendName)
            ],
          ),
        ),
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        padding: const EdgeInsets.all(fff_spacing.viewEdgeInsets),
        child: Column(
          children: widgets,
        ),
      ),
    );
  }

  Widget _mapWidget(BuildContext context, LatLng center) {
    Marker friendMarker = Marker(markerId: MarkerId("0"), position: center);
    Set<Marker> elements = [friendMarker].toSet();

    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      // rounded corners may be impossible or difficult
      child: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: center,
          zoom: 11.0,
        ),
        markers: elements,
      ),
    );
  }

  Widget _buildTextField() {
    Widget innerWidget;

    // case on FFRequest status
    if (widget.ffRequest == null) {
      innerWidget = Material(
        child: TextField(
          onChanged: (text) => this.newRequestMessage = text,
          keyboardType: TextInputType.multiline,
          maxLines: null,
          style: Theme.of(context).textTheme.body1,
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: const EdgeInsets.only(left: 5),
            fillColor: fff_colors.white,
            filled: true,
            hintText: "Write a short message to your friend!",
          ),
        ),
      );
    } else if (widget.ffRequest.isIncoming) {
      innerWidget = Text(widget.ffRequest.message,
          style: Theme.of(context).textTheme.body1);
    } else {
      // is outgoing request
      innerWidget = Text(widget.ffRequest.message,
          style: Theme.of(context).textTheme.body1);
    }

    return Container(
      margin: const EdgeInsets.all(5),
      child: innerWidget,
    );
  }

  List<Widget> _buildActionRow() {
    List<Widget> actionRow = [SizedBox(width: 10)];

    // case on the FFRequest status
    if (widget.ffRequest == null) {
      actionRow.addAll(<Widget>[
        Text(
          this.newRequestMessage.length.toString() + "/100",
          style: Theme.of(context)
              .textTheme
              .body1
              .apply(color: fff_colors.darkGray),
        ),
        Spacer(),
        MaterialButton(
          child: Text(
            "Send Request",
            style: Theme.of(context).textTheme.body1,
          ),
          onPressed: () {
            UserData otherUser = widget.user;

            fff_request_backend
                .createRequest(otherUser, this.newRequestMessage)
                .then((ffRequest) {
              widget.callback(Detail.online, ffRequest);
              Navigator.of(context)
                  .popUntil((route) => route.settings.name == Home.routeName);
            });
          },
          color: fff_colors.strongBackground,
          padding: const EdgeInsets.symmetric(horizontal: 10),
        ),
      ]);
    } else if (widget.ffRequest.isIncoming) {
      actionRow.addAll(<Widget>[
        MaterialButton(
          child: Text(
            "Decline Request",
            style: Theme.of(context).textTheme.body1,
          ),
          onPressed: () {
            fff_request_backend.actOnRequest(widget.ffRequest, "rejected");
            widget.callback(Detail.incoming, widget.ffRequest);
            Navigator.pop(context);
          },
          color: fff_colors.buttonGray,
          padding: const EdgeInsets.symmetric(horizontal: 10),
        ),
        Spacer(),
        MaterialButton(
          child: Text(
            "Accept Request",
            style: Theme.of(context).textTheme.body1,
          ),
          onPressed: () {
            fff_request_backend.actOnRequest(widget.ffRequest, "accepted");
            Navigator.pop(context);
          },
          color: fff_colors.buttonGreen,
          padding: const EdgeInsets.symmetric(horizontal: 10),
        ),
      ]);
    } else {
      // is outgoing request
      actionRow.addAll(<Widget>[
        Spacer(),
        MaterialButton(
          child: Text(
            "Withdraw Request",
            style: Theme.of(context).textTheme.body1,
          ),
          onPressed: () {
            DialogButton(
                context, "Withdrawing Request", "withdraw Collin's request?",
                () {
              fff_request_backend
                  .cancelRequest(widget.ffRequest)
                  .then((cancel) {
                widget.callback(Detail.outgoing, widget.ffRequest);
                Navigator.of(context)
                    .popUntil((route) => route.settings.name == Home.routeName);
              });
            });
          },
          color: fff_colors.buttonGray,
          padding: const EdgeInsets.symmetric(horizontal: 10),
        ),
        Spacer(),
      ]);
    }

    actionRow.add(SizedBox(width: 10));

    return actionRow;
  }
}

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Widget: the contents of the hamburger menu in the app.
class HamburgerDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: new Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          DrawerHeader(
            child: Column(
              children: <Widget>[
                Container(
                  width: 75,
                  height: 75,
                  decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    image: new DecorationImage(
                      fit: BoxFit.fill,
                      image: new NetworkImage(
                          "https://scontent.fbed1-2.fna.fbcdn.net/v/t1.0-1/c73.206.614.614a/s100x100/50735968_2302236259809637_5312553092619698176_n.jpg?_nc_cat=104&_nc_oc=AQnj-x9fkxHyDUJPaGK_RlQ_kTJhJBbDXNx29xDpk5A_7NMlgR6Nv4Qg2VCquwC9vf8&_nc_ht=scontent.fbed1-2.fna&oh=165917455e36027c7672ef070ed06e8d&oe=5E3A0206"),
                    ),
                  ),
                ),
                SizedBox(
                  height: 14,
                ),
                Text(
                  "Stella Yang",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Text("@stellay")
              ],
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              border: BorderDirectional(
                bottom: BorderSide(
                  color: Colors.orange,
                ),
              ),
            ),
          ),
          ListTile(
            title: Row(
              children: <Widget>[
                SizedBox(width: 20),
                Icon(FontAwesomeIcons.home, size: 16),
                SizedBox(width: 20),
                Text("Home"),
              ],
            ),
            onTap: () {
              // Update the state of the app.
              Navigator.popAndPushNamed(context, "/");
            },
          ),
          ListTile(
            title: Row(
              children: <Widget>[
                SizedBox(width: 20),
                Icon(FontAwesomeIcons.search, size: 16),
                SizedBox(width: 20),
                Text("Search People"),
              ],
            ),
            onTap: () {
              // Update the state of the app.
              // ...
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Row(
              children: <Widget>[
                SizedBox(width: 20),
                Icon(FontAwesomeIcons.smile, size: 16),
                SizedBox(width: 21),
                Text("Friend Requests"),
              ],
            ),
            onTap: () {
              // Update the state of the app.
              Navigator.popAndPushNamed(context, "/friend-requests");
            },
          ),
          ListTile(
            title: Row(
              children: <Widget>[
                SizedBox(width: 20),
                Icon(FontAwesomeIcons.questionCircle, size: 16),
                SizedBox(width: 20),
                Text("Help"),
              ],
            ),
            onTap: () {
              // Update the state of the app.
              // ...
              Navigator.pop(context);
            },
          ),
          new Expanded(
            child: new Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 6),
                child: ListTile(
                  title: Row(
                    children: <Widget>[
                      SizedBox(width: 20),
                      Icon(FontAwesomeIcons.powerOff, size: 16),
                      SizedBox(width: 20),
                      Text("Log Out"),
                    ],
                  ),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

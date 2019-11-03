import 'package:fff/backend/auth.dart' as fff_auth;
import 'package:fff/routes.dart' as fff_routes;
import 'package:fff/views/login.dart';
import "package:flutter/material.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";

// Widget: the contents of the hamburger menu in the app.
class HamburgerDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: new Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _createHeader(context),
          _createDrawerItem(context, FontAwesomeIcons.home, "Home",
              () => Navigator.pushReplacementNamed(context, fff_routes.home)),
          _createDrawerItem(
              context,
              FontAwesomeIcons.search,
              "Search People",
              () => Navigator.pushReplacementNamed(
                  context, fff_routes.searchPeople)),
          _createDrawerItem(
              context,
              FontAwesomeIcons.smile,
              "Friend Requests",
              () => Navigator.pushReplacementNamed(
                  context, fff_routes.friendRequest)),
          _createDrawerItem(context, FontAwesomeIcons.questionCircle, "Help",
              () => throw new UnimplementedError("TODO: QUESTION")),
          new Expanded(
            child: new Align(
              alignment: Alignment.bottomCenter,
              child: _createDrawerItem(
                  context, FontAwesomeIcons.powerOff, "Log Out", () async {
                await fff_auth.logout();
                Navigator.pushReplacementNamed(context, fff_routes.login);
              }),
            ),
          ),
        ],
      ),
    );
  }

  BoxDecoration _createHeaderProfile() {
    return BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
            fit: BoxFit.fill,
            image: NetworkImage(me.imageUrl)));
  }

  Widget _createHeader(context) {
    return DrawerHeader(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      child: Column(
        children: <Widget>[
          Container(
            width: 75,
            height: 75,
            margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            decoration: _createHeaderProfile(),
          ),
          SizedBox(height: 14),
          Text(
            me.name,
            style: Theme.of(context).textTheme.headline,
          ),
          SizedBox(height: 4),
          Text("@" + me.username,
          style: Theme.of(context).textTheme.body1),
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
    );
  }

  Widget _createDrawerItem(BuildContext context, IconData icon, String title,
          Function() onTap) =>
      ListTile(
          title: Row(children: <Widget>[
            SizedBox(width: 20),
            Icon(icon, size: 16),
            SizedBox(width: 20),
            Text(title)
          ]),
          onTap: onTap);
}

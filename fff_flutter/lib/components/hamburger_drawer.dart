import "package:flutter/material.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:fff/routes/routes.dart";

// Widget: the contents of the hamburger menu in the app.
class HamburgerDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: new Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _createHeader(),
          _createDrawerItem(
              context, FontAwesomeIcons.home, "Home", Routes.home),
          _createDrawerItem(
              context, FontAwesomeIcons.search, "Search People", "TODO_SEARCH"),
          _createDrawerItem(context, FontAwesomeIcons.smile, "Friend Requests",
              Routes.friendRequest),
          _createDrawerItem(context, FontAwesomeIcons.questionCircle, "Help",
              "TODO_QUESTION"),
          new Expanded(
            child: new Align(
              alignment: Alignment.bottomCenter,
              child: _createDrawerItem(
                  context, FontAwesomeIcons.powerOff, "Log Out", "TODO_LOGOUT"),
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
            image: NetworkImage(
                "https://scontent.fbed1-2.fna.fbcdn.net/v/t1.0-1/c73.206.614.614a/s100x100/50735968_2302236259809637_5312553092619698176_n.jpg?_nc_cat=104&_nc_oc=AQnj-x9fkxHyDUJPaGK_RlQ_kTJhJBbDXNx29xDpk5A_7NMlgR6Nv4Qg2VCquwC9vf8&_nc_ht=scontent.fbed1-2.fna&oh=165917455e36027c7672ef070ed06e8d&oe=5E3A0206")));
  }

  Widget _createHeader() {
    return DrawerHeader(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      child: Column(
        children: <Widget>[
          Container(
            width: 75,
            height: 75,
            decoration: _createHeaderProfile(),
          ),
          SizedBox(height: 14),
          Text(
            "Stella Yang",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4),
          Text("@stellay"),
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

  Widget _createDrawerItem(
      BuildContext context, IconData icon, String title, String route) {
    return ListTile(
      title: Row(children: <Widget>[
        SizedBox(width: 20),
        Icon(icon, size: 16),
        SizedBox(width: 20),
        Text(title)
      ]),
      onTap: () {
        Navigator.pushReplacementNamed(context, route);
      },
    );
  }
}

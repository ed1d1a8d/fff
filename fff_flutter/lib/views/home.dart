import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myapp/views/incoming_requests_widget.dart';
import 'package:myapp/views/outging_requests_widget.dart';
import 'online_friends_widget.dart';
import '../components/filler.dart';
import '../utils/colors.dart' as fff_colors;

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    IncomingRequestsWidget(fff_colors.background),
    OnlineFriendsWidget(fff_colors.background),
    OutgoingRequestsWidget(fff_colors.background),
  ];
  final List<String> _titles = [
    "Incoming Requests",
    "Online Friends",
    "Outgoing Requests",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: fff_colors.background,
      appBar: AppBar(
        title: Text(
          _titles[_currentIndex],
          style: TextStyle(
            color: Colors.black,
            fontSize: 28,
          ),
        ),
        backgroundColor: fff_colors.background,
        elevation: 0.0,
        iconTheme: new IconThemeData(color: Colors.black),
      ),
      endDrawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: Colors.orange,
              ),
            ),
            ListTile(
              title: Text('Item 1'),
              onTap: () {
                // Update the state of the app.
                // ...
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {
                // Update the state of the app.
                // ...
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
              // sets the background color of the `BottomNavigationBar`
              canvasColor: fff_colors.navBarBackground,
              // sets the active color of the `BottomNavigationBar` if `Brightness` is light
              primaryColor: Colors.orange,
              textTheme: Theme.of(context)
                  .textTheme
                  .copyWith(caption: new TextStyle(color: fff_colors.lightGray))),
          // sets the inactive color of the `BottomNavigationBar`
          child: SizedBox(
            height: 64,
            child: BottomNavigationBar(
              onTap: onTabTapped,
              currentIndex: _currentIndex,
              items: [
                BottomNavigationBarItem(
                    icon: new Icon(Icons.mail),
                    title: Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 6),
                      child: Text(
                        'Incoming Requests',
                        style: TextStyle(fontSize: 12),
                      ),
                    )),
                BottomNavigationBarItem(
                    icon: new Icon(Icons.person),
                    title: Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 6),
                      child: Text(
                        'Online Friends',
                        style: TextStyle(fontSize: 12),
                      ),
                    )),
                BottomNavigationBarItem(
                    icon: Icon(FontAwesomeIcons.paperPlane),
                    title: Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 6),
                      child: Text(
                        'Outgoing Requests',
                        style: TextStyle(fontSize: 12),
                      ),
                    ))
              ],
            ),
          )),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}

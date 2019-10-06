import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'incoming_requests_widget.dart';
import 'outging_requests_widget.dart';
import 'online_friends_widget.dart';
import 'timer_widget.dart';
import '../components/hamburger_drawer.dart';
import '../utils/colors.dart' as fff_colors;

class Home extends StatefulWidget {
  static TimerBox timer = new TimerBox(Duration());

  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  static TimerBox timer = new TimerBox(Duration());

  int _currentIndex = 0;

  final List<Widget> _children = [
    IncomingRequestsWidget(fff_colors.background, Home.timer),
    OnlineFriendsWidget(fff_colors.background, Home.timer),
    OutgoingRequestsWidget(fff_colors.background, Home.timer),
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
      endDrawer: HamburgerDrawer(),
      body: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 30, width: 50),
              SizedBox(
                height: 30,
//            width: MediaQuery.of(context).size.width * 0.70,
                width: 70,
                child: Home.timer,
              ),
              SizedBox(height: 30, width: 10),
              Text(
                "minutes remaining",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 30, width: 6),
              Icon(FontAwesomeIcons.questionCircle, size: 16),
            ],
          ),
          _children[_currentIndex]
        ],
      ),
      bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
              // sets the background color of the `BottomNavigationBar`
              canvasColor: fff_colors.navBarBackground,
              // sets the active color of the `BottomNavigationBar` if `Brightness` is light
              primaryColor: Colors.orange,
              textTheme: Theme.of(context).textTheme.copyWith(
                  caption: new TextStyle(color: fff_colors.darkGray))),
          // sets the inactive color of the `BottomNavigationBar`
          child: SizedBox(
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

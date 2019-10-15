import "package:fff/components/gradient_container.dart";
import "package:fff/components/hamburger_drawer.dart";
import "package:fff/components/timer_box.dart";
import "package:fff/components/url_avatar.dart";
import "package:fff/models/mock_data.dart";
import "package:fff/models/user_data.dart";
import "package:fff/utils/colors.dart" as fff_colors;
import "package:fff/utils/spacing.dart" as fff_spacing;
import "package:fff/views/friend_detail.dart";
import "package:flutter/material.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";

class Home extends StatefulWidget {
  static const String routeName = "/home";

  static final TimerBox timer = new TimerBox(MockData.timerDuration);

  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

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
          style: Theme.of(context).textTheme.title,
        ),
        backgroundColor: fff_colors.background,
        elevation: 0,
        iconTheme: new IconThemeData(color: Colors.black),
      ),
      drawer: HamburgerDrawer(),
      body: Container(
        padding: const EdgeInsets.only(
          left: fff_spacing.viewEdgeInsets,
          right: fff_spacing.viewEdgeInsets,
          bottom: fff_spacing.viewEdgeInsets,
        ),
        child: Column(
          children: <Widget>[
            Container(
              margin:
                  const EdgeInsets.only(bottom: fff_spacing.profilePicInsets),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 70,
                    height: 30,
                    margin: const EdgeInsets.only(
                        right: fff_spacing.profilePicInsets),
                    child: Home.timer,
                  ),
                  Text(
                    "minutes remaining",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        left: fff_spacing.profilePicInsets),
                    child: Icon(FontAwesomeIcons.questionCircle, size: 16),
                  ),
                ],
              ),
            ),
            this.buildProfileList(context),
          ],
        ),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          // sets the background color of the `BottomNavigationBar`
          canvasColor: fff_colors.navBarBackground,
          // sets the active color of the `BottomNavigationBar` if `Brightness` is light
          primaryColor: Colors.orange,
          textTheme: Theme.of(context).textTheme.copyWith(
                caption: new TextStyle(color: fff_colors.darkGray),
              ),
        ),
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
                    "Incoming Requests",
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ),
              BottomNavigationBarItem(
                icon: new Icon(Icons.person),
                title: Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 6),
                  child: Text(
                    "Online Friends",
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.paperPlane),
                title: Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 6),
                  child: Text(
                    "Outgoing Requests",
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Widget buildProfileList(BuildContext context) {
    final List<List<UserData>> profileListData = [
      MockData.incomingRequests,
      MockData.onlineFriends,
      MockData.outgoingRequests,
    ];

    List<UserData> data = profileListData[this._currentIndex];

    return Expanded(
      child: Container(
        color: fff_colors.background,
        child: GradientContainer(
          padding: const EdgeInsets.all(fff_spacing.profileListInsets),
          child: ListView.separated(
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () => _pushFriendDetail(context, index),
                child: this.buildProfilePane(
                  data[index].imageUrl,
                  data[index].name,
                  data[index].distance,
                  data[index].message,
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(
              height: 20,
              color: fff_colors.black,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildProfilePane(
      String imageURL, String name, String distance, String message) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding:
                    const EdgeInsets.only(right: fff_spacing.profilePicInsets),
                child: URLAvatar(
                  imageURL: imageURL,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    name,
                    style: Theme.of(context).textTheme.display2,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    distance,
                    style: Theme.of(context).textTheme.display1,
                  ),
                ],
              ),
            ],
          ),
          message == null
              ? Container()
              : Container(
                  margin:
                      const EdgeInsets.only(top: fff_spacing.profilePicInsets),
                  child: Text(
                    message,
                    style: Theme.of(context).textTheme.body1,
                  ),
                ),
        ],
      ),
    );
  }

  _pushFriendDetail(BuildContext context, int index) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => FriendDetail(index)));
  }
}

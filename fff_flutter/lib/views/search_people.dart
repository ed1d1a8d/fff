import "dart:developer";

import "package:fff/backend/friends.dart" as fff_backend_friends;
import "package:fff/components/hamburger_drawer.dart";
import "package:fff/components/search_bar.dart";
import "package:fff/components/url_avatar.dart";
import "package:fff/models/friend_request.dart";
import "package:fff/models/search_friends_data.dart";
import "package:fff/models/user_data.dart";
import "package:fff/utils/colors.dart" as fff_colors;
import "package:fff/utils/spacing.dart" as fff_spacing;
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";

class SearchPeople extends StatefulWidget {
  static const String routeName = "/search-people";

  @override
  State<StatefulWidget> createState() => SearchPeopleState();
}

class SearchPeopleState extends State<SearchPeople> {
  List<UserData> _friends;
  List<UserData> _requestedPeople;
  List<UserData> _otherPeople;

  String _filterText = "";

  @override
  initState() {
    super.initState();

    fff_backend_friends.fetchFriends().then((List<UserData> friends) {
      setState(() {
        _friends = friends;
        _friends.sort((u1, u2) => u1.name.compareTo(u2.name));
        log("Set _friends.");
      });
    });

    fff_backend_friends
        .fetchOutgoingRequests()
        .then((List<FriendRequest> outgoingRequests) {
      setState(() {
        _requestedPeople = outgoingRequests.map((fr) => fr.toUser).toList();
        _requestedPeople.sort((u1, u2) => u1.name.compareTo(u2.name));
        log("Set _requestedPeople.");
      });
    });

    fff_backend_friends.fetchNonFriends().then((List<UserData> nonFriends) {
      setState(() {
        _otherPeople = nonFriends;
        _otherPeople.sort((u1, u2) => u1.name.compareTo(u2.name));
        log("Set _otherPeople.");
      });
    });

    log("Initialized SearchPeopleState.");
  }

  void _sendFriendRequest(UserData toUser) async {
    if (await fff_backend_friends.createRequest(toUser)) {
      setState(() {
        _otherPeople.removeWhere((x) => x.id == toUser.id);
        _otherPeople.sort((u1, u2) => u1.name.compareTo(u2.name));
        _requestedPeople.add(toUser);
        _requestedPeople.sort((u1, u2) => u1.name.compareTo(u2.name));
      });
    }
  }

  bool _userVisible(UserData user) =>
      user.name.toLowerCase().contains(_filterText.toLowerCase());

  void _addUserToCombinedList(UserData toUser, List<Widget> combinedList,
      {bool addFriendButton = false}) {
    combinedList.addAll([
      Row(
        children: <Widget>[
              URLAvatar(
                imageURL: toUser.imageUrl,
              ),
              Container(
                margin: const EdgeInsets.only(left: 10),
                child: Text(
                  toUser.name,
                  style: Theme.of(context).textTheme.display2,
                ),
              ),
              Spacer(),
            ] +
            (addFriendButton
                ? [
                    Container(
                      child: MaterialButton(
                        child: Text(
                          "Add",
                          style: Theme.of(context).textTheme.body1,
                        ),
                        onPressed: () => _sendFriendRequest(toUser),
                        color: fff_colors.buttonGreen,
                        padding: const EdgeInsets.all(0),
                      ),
                    )
                  ]
                : []),
      ),
      SizedBox(height: 7),
    ]);
  }

  Widget _buildListSectionLabel(String labelText) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 15,
      ),
      child: Text(
        labelText,
        style: Theme.of(context).textTheme.subhead,
      ),
    );
  }

  List<Widget> _buildFilteredCombinedList(
      List<UserData> friends, List<UserData> otherPeople) {
    List<Widget> combinedList = <Widget>[];
    if (_friends == null || _requestedPeople == null || _otherPeople == null) {
      return combinedList;
    }

    // friends section
    combinedList.add(this._buildListSectionLabel("Friends"));
    _friends
        .where(_userVisible)
        .forEach((user) => _addUserToCombinedList(user, combinedList));

    // small divide between sections
    combinedList.add(SizedBox(height: 20));

    // other people section
    combinedList.add(this._buildListSectionLabel("Other People"));
    _requestedPeople
        .where(_userVisible)
        .forEach((user) => _addUserToCombinedList(user, combinedList));
    _otherPeople.where(_userVisible).forEach((user) =>
        _addUserToCombinedList(user, combinedList, addFriendButton: true));

    return combinedList;
  }

  @override
  Widget build(BuildContext context) {
    // build the widget list from the list of friends and other people
    List<Widget> combinedList = _buildFilteredCombinedList(
        SearchFriendsData.friends, SearchFriendsData.otherPeople);

    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        title: Row(
          children: <Widget>[
            Container(
              height: 45,
              padding: const EdgeInsets.only(right: 10),
              child: Image.asset(
                "assets/images/search-people.png",
              ),
            ),
            Text(
              "Search People",
              style: Theme.of(context).textTheme.title,
            ),
          ],
        ),
        backgroundColor: fff_colors.navBarBackground,
        elevation: 0,
        iconTheme: new IconThemeData(color: Colors.black),
      ),
      backgroundColor: fff_colors.white,
      drawer: HamburgerDrawer(),
      body:
          (_friends == null || _requestedPeople == null || _otherPeople == null)
              ? Center(child: CircularProgressIndicator())
              : Column(
                  children: <Widget>[
                    // search bar
                    Container(
                      padding: EdgeInsets.fromLTRB(
                          fff_spacing.viewEdgeInsets,
                          fff_spacing.profilePicInsets,
                          fff_spacing.viewEdgeInsets,
                          fff_spacing.profileListInsets),
                      color: fff_colors.navBarBackground,
                      child: SearchBar(
                        onChanged: (String text) {
                          setState(() {
                            _filterText = text;
                          });
                        },
                        color: fff_colors.white,
                      ),
                    ),

                    // list of friends
                    Expanded(
                      child: ListView(
                        padding: const EdgeInsets.fromLTRB(
                            fff_spacing.viewEdgeInsets,
                            fff_spacing.profilePicInsets,
                            fff_spacing.viewEdgeInsets,
                            0),
                        children: combinedList,
                      ),
                    ),
                  ],
                ),
    );
  }
}

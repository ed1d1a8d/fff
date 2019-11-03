import "package:fff/components/hamburger_drawer.dart";
import "package:fff/components/url_avatar.dart";
import "package:fff/models/user_data.dart";
import "package:fff/models/search_friends_data.dart";
import "package:fff/utils/colors.dart" as fff_colors;
import "package:fff/utils/spacing.dart" as fff_spacing;
import "package:fff/components/search_bar.dart";
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";

class SearchPeople extends StatefulWidget {
  static const String routeName = "/search-people";

  @override
  State<StatefulWidget> createState() => SearchPeopleState();
}

class SearchPeopleState extends State<SearchPeople> {
  String filterText = "";

  bool _friendAtIndexVisible(List<UserData> friends, int index) {
    return friends[index]
        .name
        .toLowerCase()
        .contains(this.filterText.toLowerCase());
  }

  bool _otherPeopleAtIndexVisible(List<UserData> otherPeople, int index) {
    return otherPeople[index]
        .name
        .toLowerCase()
        .contains(this.filterText.toLowerCase());
  }

  void _addUserToCombinedList(
      UserData user, List<Widget> combinedList, bool divider) {
    combinedList.add(Row(
      children: <Widget>[
        URLAvatar(
          imageURL: user.imageUrl,
        ),
        Container(
          margin: const EdgeInsets.only(left: 10),
          child: Text(
            user.name,
            style: Theme.of(context).textTheme.display2,
          ),
        ),
        Spacer(),
      ],
    ));

    // add the divider
    if (divider) combinedList.add(Divider(color: fff_colors.black));
  }

  Widget _buildListSectionLabel(String labelText) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 10,
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

    // friends section
    combinedList.add(this._buildListSectionLabel("Friends"));
    for (int a = 0; a < friends.length; a++) {
      if (!this._friendAtIndexVisible(friends, a)) continue;
      this._addUserToCombinedList(
          friends[a], combinedList, a < friends.length - 1);
    }

    // small divide between sections
    combinedList.add(SizedBox(height: 20));

    // other people section
    combinedList.add(this._buildListSectionLabel("Other People"));
    for (int a = 0; a < otherPeople.length; a++) {
      if (!this._otherPeopleAtIndexVisible(otherPeople, a)) continue;
      this._addUserToCombinedList(
          otherPeople[a], combinedList, a < friends.length - 1);
    }

    combinedList.add(SizedBox(height: 20));

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
      body: Column(
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
                  filterText = text;
                });
              },
              color: fff_colors.white,
            ),
          ),

          // list of friends
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(fff_spacing.viewEdgeInsets,
                  fff_spacing.profilePicInsets, fff_spacing.viewEdgeInsets, 0),
              children: combinedList,
            ),
          ),
        ],
      ),
    );
  }
}

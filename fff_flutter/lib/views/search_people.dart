import "package:fff/components/hamburger_drawer.dart";
import "package:fff/components/url_avatar.dart";
import "package:fff/models/mock_data.dart";
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
  final scaffoldKey = GlobalKey<ScaffoldState>();

  String filterText = "";

  bool friendAtIndexVisible(int index) {
    return SearchFriendsData.friends[index].name
        .toLowerCase()
        .contains(this.filterText.toLowerCase());
  }

  bool otherAtIndexVisible(int index) {
    return SearchFriendsData.otherPeople[index].name
        .toLowerCase()
        .contains(this.filterText.toLowerCase());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(right: 10),
              child: Image.asset(
                "assets/images/search-people.png",
              ),
            ),
            Text(
              "Search People",
              style: Theme
                  .of(context)
                  .textTheme
                  .title,
            ),
          ],
        ),
        backgroundColor: fff_colors.navBarBackground,
        elevation: 0.0,
        iconTheme: new IconThemeData(color: Colors.black),
      ),
      backgroundColor: fff_colors.white,
      drawer: HamburgerDrawer(),
      body: SafeArea(
        child: Container(
          constraints: BoxConstraints.expand(),
          child: Container(
            constraints: BoxConstraints.expand(),
            child: Column(
              children: <Widget>[
                // List of friends and search
                Expanded(
                  child: Column(
                    children: <Widget>[

                      Container(
                        padding: EdgeInsets.fromLTRB(40, 20, 40, 20),
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
                      // Search bar for friends.

                      // List of friends
                      Expanded(
                        child: ListView.separated(
                          padding: const EdgeInsets.fromLTRB(40, 20, 40, 20),
                          itemCount: SearchFriendsData.friends.length,
                          itemBuilder: (BuildContext context, int index) {
                            return this.friendAtIndexVisible(index)
                                ? Row(
                              children: <Widget>[
                                URLAvatar(
                                  imageURL: SearchFriendsData
                                      .friends[index].imageUrl,
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    SearchFriendsData.friends[index].name,
                                    style:
                                    Theme
                                        .of(context)
                                        .textTheme
                                        .display2,
                                  ),
                                ),
                                Spacer(),
                              ],
                            )
                                : Container();
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return this.friendAtIndexVisible(index)
                                ? Divider(
                              color: fff_colors.black,
                            )
                                : Container();
                          },
                        ),
                      ),

                      // List of other people on FFF
//                      Expanded(
//                        child: ListView.separated(
//                          padding: const EdgeInsets.fromLTRB(40, 20, 40, 20),
//                          itemCount: SearchFriendsData.otherPeople.length,
//                          itemBuilder: (BuildContext context, int index) {
//                            return this.friendAtIndexVisible(index)
//                                ? Row(
//                              children: <Widget>[
//                                URLAvatar(
//                                  imageURL: SearchFriendsData
//                                      .otherPeople[index].imageUrl,
//                                ),
//                                Container(
//                                  margin: const EdgeInsets.only(left: 10),
//                                  child: Text(
//                                    SearchFriendsData.otherPeople[index].name,
//                                    style:
//                                    Theme
//                                        .of(context)
//                                        .textTheme
//                                        .display2,
//                                  ),
//                                ),
//                                Spacer(),
//                              ],
//                            )
//                                : Container();
//                          },
//                          separatorBuilder: (BuildContext context, int index) {
//                            return this.friendAtIndexVisible(index)
//                                ? Divider(
//                              color: fff_colors.black,
//                            )
//                                : Container();
//                          },
//                        ),
//                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

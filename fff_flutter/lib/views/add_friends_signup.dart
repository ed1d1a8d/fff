import "package:fff/components/fff_check_box.dart";
import "package:fff/components/gradient_container.dart";
import "package:fff/components/search_bar.dart";
import "package:fff/components/url_avatar.dart";
import "package:fff/models/mock_data.dart";
import "package:fff/utils/colors.dart" as fff_colors;
import "package:fff/utils/spacing.dart" as fff_spacing;
import "package:flutter/material.dart";

class AddFriendsSignup extends StatefulWidget {
  static const String routeName = "add-friends-signup";

  @override
  _AddFriendsSignupState createState() => _AddFriendsSignupState();
}

class _AddFriendsSignupState extends State<AddFriendsSignup> {
  // is null if proper subset of friends is checked
  int numFriendsChecked = 0;
  List<bool> isFriendChecked =
      new List.filled(MockData.onlineFriends.length, false);
  String filterText = "";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: fff_colors.background,
        padding: const EdgeInsets.all(fff_spacing.viewEdgeInsets),
        child: Column(
          children: <Widget>[
            // Introduction text and image
            Container(
              alignment: Alignment.topLeft,
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Free\nFor\nFood?",
                        style: Theme.of(context).textTheme.display3,
                      ),
                      Image.asset(
                        "assets/images/pizza-burger.png",
                        height: 80,
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.topLeft,
                        margin: const EdgeInsets.symmetric(vertical: 15),
                        child: Text(
                          "Thanks for joining Free For Food!",
                          style: Theme.of(context).textTheme.subhead,
                        ),
                      ),
                      Text(
                        "Start by adding friends so you can share your location when you are both Free For Food!",
                        style: Theme.of(context).textTheme.body1,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // List of friends and search
            Expanded(
              child: GradientContainer(
                margin: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 0,
                ),
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: <Widget>[
                    // Search bar for friends.
                    SearchBar(
                      onChanged: (String text) {
                        setState(() {
                          filterText = text;
                        });
                      },
                    ),

                    // Select all checkbox
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 12.5,
                          ),
                          child: Text(
                            "Select all",
                            style: Theme.of(context).textTheme.body1,
                          ),
                        ),
                        FFFCheckBox(
                          onTap: () {
                            setState(() {
                              if (numFriendsChecked !=
                                  MockData.onlineFriends.length) {
                                numFriendsChecked =
                                    MockData.onlineFriends.length;
                                isFriendChecked = new List.filled(
                                    MockData.onlineFriends.length, true);
                              } else {
                                numFriendsChecked = 0;
                                isFriendChecked = new List.filled(
                                    MockData.onlineFriends.length, false);
                              }
                            });
                          },
                          checked: this.numFriendsChecked ==
                                  MockData.onlineFriends.length
                              ? true
                              : this.numFriendsChecked == 0 ? false : null,
                        ),
                      ],
                    ),

                    // List of friends
                    Expanded(
                      child: ListView.separated(
                        padding: const EdgeInsets.only(top: 5),
                        itemCount: MockData.onlineFriends.length,
                        itemBuilder: (BuildContext context, int index) {
                          return this.friendAtIndexVisible(index)
                              ? Row(
                                  children: <Widget>[
                                    URLAvatar(
                                      imageURL: MockData
                                          .onlineFriends[index].imageUrl,
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        MockData.onlineFriends[index].name,
                                        style:
                                            Theme.of(context).textTheme.body1,
                                      ),
                                    ),
                                    Spacer(),
                                    FFFCheckBox(
                                      onTap: () {
                                        setState(() {
                                          numFriendsChecked +=
                                              isFriendChecked[index] ? -1 : 1;
                                          isFriendChecked[index] =
                                              !isFriendChecked[index];
                                        });
                                      },
                                      checked: this.isFriendChecked[index],
                                    ),
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
                  ],
                ),
              ),
            ),

            // Add friends button
            Container(
              child: MaterialButton(
                child: Text(
                  "Add " +
                      this.numFriendsChecked.toString() +
                      " Selected Friends",
                  style: Theme.of(context).textTheme.button,
                ),
                onPressed: () {
                  print("TODO BACKEND");
                },
                color: fff_colors.strongBackground,
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 25,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool friendAtIndexVisible(int index) {
    return MockData.onlineFriends[index].name
        .toLowerCase()
        .contains(this.filterText.toLowerCase());
  }
}

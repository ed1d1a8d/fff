import "dart:async";
import "dart:developer";

import "package:fff/backend/friends.dart" as fff_backend_friends;
import "package:fff/components/fff_check_box.dart";
import "package:fff/components/gradient_container.dart";
import "package:fff/components/search_bar.dart";
import "package:fff/components/url_avatar.dart";
import "package:fff/models/user_data.dart";
import "package:fff/routes.dart" as fff_routes;
import "package:fff/utils/colors.dart" as fff_colors;
import "package:fff/utils/no_delay_periodic_timer.dart";
import "package:fff/utils/spacing.dart" as fff_spacing;
import "package:flutter/material.dart";

class AddFriendsSignup extends StatefulWidget {
  static const String routeName = "add-friends-signup";

  @override
  _AddFriendsSignupState createState() => _AddFriendsSignupState();
}

class _AddFriendsSignupState extends State<AddFriendsSignup> {
  // is null if proper subset of friends is checked

  List<UserData> _fbFriends;
  int _numFriendsChecked = 0;
  int _numFriends;
  List<bool> _isFriendChecked;

  String filterText = "";

  static const _fetchPeriod = const Duration(seconds: 120);
  Timer _fetchTimer;

  @override
  void initState() {
    super.initState();

    _fetchTimer =
        noDelayPeriodicTimer(_fetchPeriod, this._handleFetchTimerCalled);
  }

  void _handleFetchTimerCalled() async {
    try {
      final List<UserData> fbFriends =
          await fff_backend_friends.fetchFBFriends();

      if (this.mounted) {
        setState(() {
          _fbFriends = fbFriends;
          _numFriendsChecked = _fbFriends.length;
          _numFriends = _fbFriends.length;
          _isFriendChecked = new List.filled(_fbFriends.length, true);
        });
      }
    } catch (error) {
      log("$error");
    }
  }

  @override
  dispose() {
    log("dispose() called on home.");
    _fetchTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: fff_colors.background,
        child: SafeArea(
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
                                  if (_numFriendsChecked != _numFriends) {
                                    _numFriendsChecked = _numFriends;
                                    _isFriendChecked =
                                        new List.filled(_numFriends, true);
                                  } else {
                                    _numFriendsChecked = 0;
                                    _isFriendChecked =
                                        new List.filled(_numFriends, false);
                                  }
                                });
                              },
                              checked: this._numFriendsChecked == _numFriends
                                  ? true
                                  : this._numFriendsChecked == 0 ? false : null,
                            ),
                          ],
                        ),

                        // List of friends

                        _fbFriends == null
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : (_fbFriends.length == 0
                                ? Text(
                                    "You are the first of your Facebook friends using FFF! (Or maybe you've already added all of your Facebook friends.)",
                                    style: Theme.of(context).textTheme.display2)
                                : Expanded(
                                    child: ListView.separated(
                                      padding: const EdgeInsets.only(top: 5),
                                      itemCount: _numFriends,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return this.friendAtIndexVisible(index)
                                            ? Row(
                                                children: <Widget>[
                                                  URLAvatar(
                                                    imageURL: _fbFriends[index]
                                                        .imageUrl,
                                                  ),
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            left: 10),
                                                    child: Text(
                                                      _fbFriends[index].name,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .display2,
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  FFFCheckBox(
                                                    onTap: () {
                                                      setState(() {
                                                        _numFriendsChecked +=
                                                            _isFriendChecked[
                                                                    index]
                                                                ? -1
                                                                : 1;
                                                        _isFriendChecked[
                                                                index] =
                                                            !_isFriendChecked[
                                                                index];
                                                      });
                                                    },
                                                    checked:
                                                        this._isFriendChecked[
                                                            index],
                                                  ),
                                                ],
                                              )
                                            : Container();
                                      },
                                      separatorBuilder:
                                          (BuildContext context, int index) {
                                        return this.friendAtIndexVisible(index)
                                            ? Divider(
                                                color: fff_colors.black,
                                              )
                                            : Container();
                                      },
                                    ),
                                  )),
                      ],
                    ),
                  ),
                ),

                // Add friends button
                Container(
                  child: MaterialButton(
                    child: Text(
                      "Add " +
                          this._numFriendsChecked.toString() +
                          " Selected Friends",
                      style: Theme.of(context).textTheme.button,
                    ),
                    onPressed: () async {
                      final List<UserData> friendsToAdd = [];

                      if (_fbFriends != null) {
                        for (int i = 0; i < _fbFriends.length; i++) {
                          if (_isFriendChecked[i]) {
                            // if friend is checked, add them
                            friendsToAdd.add(_fbFriends[i]);
                            print(_fbFriends[i].name);
                          }
                        }
                      }

                      if (await fff_backend_friends
                          .bulkCreateRequest(friendsToAdd)) {
                        Navigator.pushReplacementNamed(
                            context, fff_routes.home);
                      }
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
        ));
  }

  bool friendAtIndexVisible(int index) {
    return _fbFriends[index]
        .name
        .toLowerCase()
        .contains(this.filterText.toLowerCase());
  }
}

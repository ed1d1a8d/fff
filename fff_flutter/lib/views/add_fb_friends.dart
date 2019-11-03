import "package:fff/components/fff_check_box.dart";
import "package:fff/backend/constants.dart" as fff_backend_constants;
import "dart:async";
import "package:fff/components/gradient_container.dart";
import "package:fff/components/search_bar.dart";
import "package:fff/components/url_avatar.dart";
import "package:fff/models/user_data.dart";
import "package:fff/backend/auth.dart" as fff_auth;
import "package:fff/routes.dart" as fff_routes;
import "package:fff/utils/colors.dart" as fff_colors;
import "package:fff/utils/spacing.dart" as fff_spacing;
import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import "package:fff/utils/no_delay_periodic_timer.dart";
import "dart:developer";
import "package:fff/components/hamburger_drawer.dart";



class AddFBFriends extends StatefulWidget {
  static const String routeName = "add-fb-friends";

  @override
  _AddFBFriendsState createState() => _AddFBFriendsState();
}


class _AddFBFriendsState extends State<AddFBFriends> {
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

    _fetchTimer = noDelayPeriodicTimer(_fetchPeriod, this._handleFetchTimerCalled);
  }

  void _handleFetchTimerCalled() async {
    try {
      final List<UserData> fbFriends = await this._fetchSetData();

      if (this.mounted) {
        setState(() {
          _fbFriends = fbFriends;
          _numFriendsChecked = _fbFriends.length;
          _numFriends = _fbFriends.length;
          _isFriendChecked =
          new List.filled(_fbFriends.length, true);
        });
      }
    }
    catch (error) {
      log("$error");
    }
  }

  // Analogous to _fetchLobbyData()
  Future<List<UserData>> _fetchSetData() async {
    List tempFriendList;

    await Future.wait([
          () async {
        tempFriendList = await Future.wait([
          fetchFBFriendsFuture()
        ]);
        log("Fetched lobby user data.");
      }(),
    ]);

    return tempFriendList[0];
  }

  // Analogous to fetchIncomingRequests
  Future<List<UserData>> fetchFBFriendsFuture() async {
//    if (fff_backend_constants.localMockData) {
//      return MockData.onlineFriends;
//    }

    final response = await http.post(
      fff_backend_constants.server_location + "/api/fbfriends.json",
      body: {"access_token": fff_auth.accessToken},
      headers: fff_auth.getAuthHeaders(),
    );

    if (response.statusCode != 200)
      throw new Exception("Failed to get FB Friends friends...");

    return UserData.listFromJsonString(response.body);
  }

  @override
  dispose() {
    log("dispose() called on home.");
    _fetchTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                "Add FB Friends",
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


      Container (
          color: fff_colors.background,
          child: SafeArea(
            child: Container(
              color: fff_colors.background,
              padding: const EdgeInsets.all(fff_spacing.viewEdgeInsets),
              child: Column(
                children: <Widget>[
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
                                    if (_numFriendsChecked !=
                                        _numFriends) {
                                      _numFriendsChecked =
                                          _numFriends;
                                      _isFriendChecked = new List.filled(
                                          _numFriends, true);
                                    } else {
                                      _numFriendsChecked = 0;
                                      _isFriendChecked = new List.filled(
                                          _numFriends, false);
                                    }
                                  });
                                },
                                checked: this._numFriendsChecked ==
                                    _numFriends
                                    ? true
                                    : this._numFriendsChecked == 0 ? false : null,
                              ),
                            ],
                          ),

                          // List of friends

                          _fbFriends == null ? Center(
                            child: CircularProgressIndicator(),
                          ) :

                          (_fbFriends.length == 0 ? Column (
                            children: <Widget>[
                              Text("You are the first of your Facebook friends using FFF!",
                                  style: Theme.of(context).textTheme.display2),
                              SizedBox(height: 12),
                              Text("Or maybe you've added all your FB friends already.",
                                  style: Theme.of(context).textTheme.display2),
                            ],

                          )
                              : Expanded(
                            child: ListView.separated(
                              padding: const EdgeInsets.only(top: 5),
                              itemCount: _numFriends,
                              itemBuilder: (BuildContext context, int index) {
                                return this.friendAtIndexVisible(index)
                                    ? Row(
                                  children: <Widget>[
                                    URLAvatar(
                                      imageURL: _fbFriends[index].imageUrl,
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        _fbFriends[index].name,
                                        style:
                                        Theme.of(context).textTheme.display2,
                                      ),
                                    ),
                                    Spacer(),
                                    FFFCheckBox(
                                      onTap: () {
                                        setState(() {
                                          _numFriendsChecked +=
                                          _isFriendChecked[index] ? -1 : 1;
                                          _isFriendChecked[index] =
                                          !_isFriendChecked[index];
                                        });
                                      },
                                      checked: this._isFriendChecked[index],
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
                      onPressed: () {
                        print("TODO BACKEND");
                        List<UserData> friendsToAdd = [];

                        if (_fbFriends != null) {
                          for (int i = 0; i < _fbFriends.length; i++) {
                            if (_isFriendChecked[i]) {
                              // if friend is checked, add them
                              friendsToAdd.add(_fbFriends[i]);
                              print(_fbFriends[i].name);
                            }
                          }
                        }

                        // Friends to add contains the UserDatas of all the selected friends

                        // just go to the home page
                        Navigator.pushReplacementNamed(context, fff_routes.home);
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
          )
      ));
  }


  bool friendAtIndexVisible(int index) {
    return _fbFriends[index].name
        .toLowerCase()
        .contains(this.filterText.toLowerCase());
  }
}

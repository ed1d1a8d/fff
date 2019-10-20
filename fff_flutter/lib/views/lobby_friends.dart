import "dart:async";

import "package:fff/backend/lobby.dart" as fff_lobby_backend;
import "package:fff/components/gradient_container.dart";
import "package:fff/components/url_avatar.dart";
import "package:fff/models/user_data.dart";
import "package:fff/utils/no_delay_periodic_timer.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";

class LobbyFriends extends StatefulWidget {
  final Color color;

  LobbyFriends(this.color);

  @override
  _LobbyFriendsState createState() => new _LobbyFriendsState();
}

class _LobbyFriendsState extends State<LobbyFriends> {
  List<UserData> _onlineFriends;

  Timer _fetchTimer;
  static const _fetchPeriod = const Duration(seconds: 5);

  @override
  initState() {
    super.initState();

    _fetchTimer = noDelayPeriodicTimer(_fetchPeriod, () async {
      try {
        final List<UserData> newOnlineFriends =
            await fff_lobby_backend.fetchOnlineFriends();
        print("Fetched new lobby friends");
        setState(() => _onlineFriends = newOnlineFriends);
      } catch (error) {
        print("Failed to fetch friends LOBBYFRIENDS. $error");
      }
    });
  }

  @override
  dispose() {
    _fetchTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.color,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.center,
          ),
          SizedBox(
            height: 30,
          ),
          Stack(
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.65,
                width: MediaQuery.of(context).size.width - 100,
                child: GradientContainer(),
              ),
              Container(
                  height: MediaQuery.of(context).size.height * 0.65,
                  width: MediaQuery.of(context).size.width - 100,
                  child: _onlineFriends == null
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.separated(
                          padding: const EdgeInsets.all(8),
                          itemCount: _onlineFriends.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              height: 55,
                              child: Row(
                                children: <Widget>[
                                  SizedBox(
                                    width: 20,
                                  ),
                                  URLAvatar(
                                    imageURL: _onlineFriends[index].imageUrl,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(_onlineFriends[index].name,
                                          style: Theme.of(context)
                                              .textTheme
                                              .display2),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      Text("10 miles",
                                          style: Theme.of(context)
                                              .textTheme
                                              .display1)
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) =>
                              const Divider(),
                        )),
            ],
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}

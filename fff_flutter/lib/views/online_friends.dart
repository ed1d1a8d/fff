import "dart:async";

import "package:fff/components/gradient_container.dart";
import "package:fff/components/url_avatar.dart";
import "package:fff/models/mock_data.dart";
import "package:fff/models/user_data.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";

class OnlineFriends extends StatefulWidget {
  final Color color;

  OnlineFriends(this.color);

  @override
  _OnlineFriendsState createState() => new _OnlineFriendsState();
}

class _OnlineFriendsState extends State<OnlineFriends> {
  List<UserData> _onlineFriends;

  Timer _fetchTimer;
  static const _fetchPeriod = const Duration(seconds: 5);

  Future<List<UserData>> fetchOnlineFriends() async {
    // TODO: Implement networked version.
    return MockData.onlineFriends;
  }

  @override
  initState() {
    super.initState();

    // Fire off a fetch immediately
    fetchOnlineFriends().then((newOnlineFriends) =>
        setState(() => _onlineFriends = newOnlineFriends));

    _fetchTimer = new Timer.periodic(_fetchPeriod, (_) async {
      final List<UserData> newOnlineFriends = await fetchOnlineFriends();
      setState(() => _onlineFriends = newOnlineFriends);
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

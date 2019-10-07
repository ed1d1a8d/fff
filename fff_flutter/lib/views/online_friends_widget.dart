import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../components/gradient_container.dart';
import '../utils/colors.dart' as fff_colors;
import '../models/mock_data.dart';
import 'timer_widget.dart';

class OnlineFriendsWidget extends StatelessWidget {
  final Color color;
  TimerBox timer;

  OnlineFriendsWidget(this.color, this.timer);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
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
                  child: ListView.separated(
                    padding: const EdgeInsets.all(8),
                    itemCount: MockData.onlineFriends.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        height: 55,
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                              width: 20,
                            ),
                            Container(
                                width: 44.0,
                                height: 44.0,
                                decoration: new BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: new DecorationImage(
                                      fit: BoxFit.fill,
                                      image: new NetworkImage(MockData
                                          .onlineFriends[index].imageURL),
                                    ))),
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(MockData.onlineFriends[index].name,
                                    style: TextStyle(
                                      fontSize: 16,
                                    )),
                                SizedBox(
                                  height: 6,
                                ),
                                Text("10 miles",
                                    style: TextStyle(
                                      fontSize: fff_colors.distanceFontSize,
                                    ))
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

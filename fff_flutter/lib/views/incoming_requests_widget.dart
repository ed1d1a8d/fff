import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../utils/colors.dart' as fff_colors;

class IncomingRequestsWidget extends StatelessWidget {
  final Color color;

  IncomingRequestsWidget(this.color);

  final List<String> names = <String>[
    "Edward Park",
    "Tony Wang",
    "Yang Yan",
  ];
  final List<String> imageURLs = <String>[
    "https://scontent.fbed1-2.fna.fbcdn.net/v/t1.0-1/p100x100/67764166_1754110728066134_419834560717520896_n.jpg?_nc_cat=104&_nc_oc=AQkJsQZJ0QscZH7iqA49wp3J9xo5aUciJyEWiQySEGqYrYPjaxB-9NornY4QUSuhjSM&_nc_ht=scontent.fbed1-2.fna&oh=ef965d3096dc3ee1078291b299d9e2dc&oe=5E3B0351",
    "https://scontent.fbed1-1.fna.fbcdn.net/v/t1.0-1/p100x100/36260983_1748243281879694_1952299954449940480_n.jpg?_nc_cat=100&_nc_oc=AQlZsHDG6BMr74sshMSCm9ycoy5mLmw8Q3nXKFelctR8gUI4-0y-Q-H7K5-FbOXxGmQ&_nc_ht=scontent.fbed1-1.fna&oh=fbc25093352319f8b38c8a16a3b3e4e6&oe=5E353861",
    "https://scontent.fbed1-2.fna.fbcdn.net/v/t1.0-1/p100x100/69202283_2609263479119292_7576641202875793408_n.jpg?_nc_cat=111&_nc_oc=AQmnvQqWfFr2kMHSzp3SBqfN8x9oQi8gIsTwAJySGes4ORxnwmlQ_BM0E4HAi4fVKrY&_nc_ht=scontent.fbed1-2.fna&oh=2b2aee081bedb20be1c6e13b33e733ff&oe=5E37B2F1",
  ];
  final List<String> distances = <String>[
    "0.1mi",
    "5mi",
    "60mi",
  ];
  final List<String> messages = <String>[
    "Hey let's get beantown!",
    "Wanna get Anna's?",
    "We should go get Kenka",
  ];

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
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 30, width: 50),
              SizedBox(
                height: 30,
//            width: MediaQuery.of(context).size.width * 0.70,
                width: 70,
                child: TimerBox("0:15:39"),
              ),
              SizedBox(height: 30, width: 10),
              Text(
                "minutes remaining",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 30, width: 6),
              Icon(FontAwesomeIcons.questionCircle, size: 16),
            ],
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
                    itemCount: names.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        height: 78,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
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
                                          image: new NetworkImage(imageURLs[index]),
                                        ))),
                                SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(names[index],
                                        style: TextStyle(
                                          fontSize: 16,
                                        )),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Text(distances[index],
                                        style: TextStyle(
                                          fontSize: fff_colors.distanceFontSize,
                                        ))
                                  ],
                                ),
                              ],
                            ),

                            Padding(
                              padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
                              child: Text(messages[index],
                                style: TextStyle(
                                  fontSize: 11,
                                ),
                              ),
                            )


                          ],
                        )

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

class PaddedWhiteBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
      Padding(
          padding: EdgeInsets.fromLTRB(1, 1, 1, 1),
          child:
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
            ),
          )
      );
  }
}

class TimerBox extends StatefulWidget {
  String _timer = "";

  TimerBox(this._timer);

  @override
  State<StatefulWidget> createState() {
    return _TimerBoxState();
  }
}

class _TimerBoxState extends State<TimerBox> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.orange,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        Positioned.fill(
            child: Align(
                alignment: Alignment.center,
                child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 1, 0, 0),
                    child: Text(
                      widget._timer,
                      style: TextStyle(fontSize: 14),
                    )))),
      ],
    );
  }
}

class GradientContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        gradient: new LinearGradient(
          colors: [fff_colors.gradientTop, fff_colors.gradientBottom],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: PaddedWhiteBox(),
    );
  }
}
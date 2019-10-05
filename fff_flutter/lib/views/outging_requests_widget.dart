import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../utils/colors.dart' as fff_colors;

class OutgoingRequestsWidget extends StatelessWidget {
  final Color color;

  OutgoingRequestsWidget(this.color);

  final List<String> names = <String>[
    "Jennifer Wang",
    "Jing Lin",
  ];
  final List<String> imageURLs = <String>[
    "https://scontent.fbed1-2.fna.fbcdn.net/v/t1.0-1/p100x100/47687689_1488739577925807_9042020036373381120_n.jpg?_nc_cat=107&_nc_oc=AQmnMZm54OWVUQJtx8R_1jhezTCrNrLZx6A7KI8ZcSNdMYlUePw1t45iSMs3uVDAT_M&_nc_ht=scontent.fbed1-2.fna&oh=32a121a891b5eecf356fb23b9a65be28&oe=5DFC6F1D",
    "https://scontent.fbed1-1.fna.fbcdn.net/v/t1.0-1/p100x100/58378676_2154998581255013_2664854016906756096_n.jpg?_nc_cat=100&_nc_oc=AQlH1dQaOh3xXehFINKExH8JFHTTcNdXY3eUdjlkYCCFPfF60e9zQ45ksL8_t8imilA&_nc_ht=scontent.fbed1-1.fna&oh=7db50a6238f1b0a1bb79473c1a137320&oe=5E310E0A",
  ];
  final List<String> distances = <String>[
    "0.2mi",
    "0.35mi",
  ];
  final List<String> messages = <String>[
    "Hi Jenn! Let's get food",
    "It's been a while! Want to grab some food?",
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

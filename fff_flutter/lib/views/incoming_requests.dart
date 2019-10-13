import "package:flutter/material.dart";
import "package:fff/utils/colors.dart" as fff_colors;
import "package:fff/components/gradient_container.dart";
import "package:fff/components/url_avatar.dart";

class IncomingRequests extends StatelessWidget {
  final Color color;

  IncomingRequests(this.color);

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
                                  URLAvatar(
                                    imageURL: imageURLs[index],
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
                                      Text(names[index],
                                          style: Theme.of(context)
                                              .textTheme
                                              .display2),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      Text(distances[index],
                                          style: Theme.of(context)
                                              .textTheme
                                              .display1)
                                    ],
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
                                child: Text(
                                  messages[index],
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              )
                            ],
                          ));
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

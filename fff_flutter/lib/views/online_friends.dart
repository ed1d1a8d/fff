import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:fff/models/mock_data.dart";
import "package:fff/components/gradient_container.dart";
import "package:fff/components/url_avatar.dart";

class OnlineFriends extends StatelessWidget {
  final Color color;

  OnlineFriends(this.color);

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
                            URLAvatar(
                              imageURL: MockData.onlineFriends[index].imageURL,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(MockData.onlineFriends[index].name,
                                    style:
                                        Theme.of(context).textTheme.display2),
                                SizedBox(
                                  height: 6,
                                ),
                                Text("10 miles",
                                    style: Theme.of(context).textTheme.display1)
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

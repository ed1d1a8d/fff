import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../components/gradient_container.dart';
import '../components/search_bar.dart';
import '../components/check_box.dart';
import '../utils/colors.dart' as fff_colors;

final List<String> friendNames = <String>[
  "Cynthia Zhou",
  "Janice Lee",
  "Charlotte Sun",
  "Sophia Kwon",
  "Xiao Wang",
];

class AddFriendsSignup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: fff_colors.background,
      padding: const EdgeInsets.all(35),
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
                      style: Theme.of(context).textTheme.title,
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
                    color: fff_colors.lightGray,
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
                      CheckBox(),
                    ],
                  ),

                  // List of friends
                  Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.only(top: 5),
                      itemCount: friendNames.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Row(
                          children: <Widget>[
                            CircleAvatar(
                              radius: 25,
                              backgroundImage: AssetImage(
                                "assets/images/xiao-wang.jpg",
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 10),
                              child: Text(
                                friendNames[index],
                                style: Theme.of(context).textTheme.body2,
                              ),
                            ),
                            Spacer(),
                            CheckBox(),
                          ],
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return Divider(
                          color: fff_colors.black,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Add friends button
          Container(
            child: CupertinoButton(
              child: Text(
                "Add 5 Selected Friends",
                style: Theme.of(context).textTheme.button,
              ),
              onPressed: () {},
              color: fff_colors.strongBackground,
              padding: const EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 25,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

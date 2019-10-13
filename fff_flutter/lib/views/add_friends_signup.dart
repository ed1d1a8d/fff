import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../components/gradient_container.dart';
import '../components/search_bar.dart';
import '../components/fff_check_box.dart';
import '../models/mock_data.dart';
import '../utils/colors.dart' as fff_colors;

class AddFriendsSignup extends StatefulWidget {
  static const String routeName = 'add-friends-signup';

  @override
  _AddFriendsSignupState createState() => _AddFriendsSignupState();
}

class _AddFriendsSignupState extends State<AddFriendsSignup> {
  // is null if proper subset of friends is checked
  int numFriendsChecked = 0;
  List<bool> isFriendChecked = new List.filled(MockData.names.length, false);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: fff_colors.background,
        padding: const EdgeInsets.all(30),
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
                        FFFCheckBox(
                          onTap: () {
                            setState(() {
                              if (numFriendsChecked != MockData.names.length) {
                                numFriendsChecked = MockData.names.length;
                                isFriendChecked = new List.filled(
                                    MockData.names.length, true);
                              } else {
                                numFriendsChecked = 0;
                                isFriendChecked = new List.filled(
                                    MockData.names.length, false);
                              }
                            });
                          },
                          checked:
                              this.numFriendsChecked == MockData.names.length
                                  ? true
                                  : this.numFriendsChecked == 0 ? false : null,
                        ),
                      ],
                    ),

                    // List of friends
                    Expanded(
                      child: ListView.separated(
                        padding: const EdgeInsets.only(top: 5),
                        itemCount: MockData.names.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Row(
                            children: <Widget>[
                              Container(
                                width: 44,
                                height: 44,
                                decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: new DecorationImage(
                                    fit: BoxFit.fill,
                                    image: new NetworkImage(
                                        MockData.imageURLs[index]),
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 10),
                                child: Text(
                                  MockData.names[index],
                                  style: Theme.of(context).textTheme.body2,
                                ),
                              ),
                              Spacer(),
                              FFFCheckBox(
                                onTap: () {
                                  setState(() {
                                    numFriendsChecked +=
                                        isFriendChecked[index] ? -1 : 1;
                                    isFriendChecked[index] =
                                        !isFriendChecked[index];
                                  });
                                },
                                checked: this.isFriendChecked[index],
                              ),
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
                  "Add " +
                      this.numFriendsChecked.toString() +
                      " Selected Friends",
                  style: Theme.of(context).textTheme.button,
                ),
                onPressed: () {
                  print("TODO: INTEGRATE WITH BACKEND");
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
    );
  }
}

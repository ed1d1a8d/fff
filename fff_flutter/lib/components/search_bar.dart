import 'package:flutter/material.dart';

// Widget for a search bar with variable background color.
class SearchBar extends StatelessWidget {
  final Color color;

  SearchBar({
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: this.color,
        borderRadius: BorderRadius.circular(10),
      ),
      height: 35,
      child: Row(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(7.5),
            child: Image.asset(
              "assets/images/magnifying-glass.png",
              fit: BoxFit.contain,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 5),
            child: Text(
              "Name or username",
              style: Theme.of(context).textTheme.body1,
            ),
          ),
        ],
      ),
    );
  }
}

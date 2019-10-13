import 'package:flutter/material.dart';
import '../utils/colors.dart' as fff_colors;

// Stateful widget for a search bar with variable background color.

class SearchBar extends StatefulWidget {
  final Color color;
  final String hintText;
  final void Function(String) onChanged;

  SearchBar({
    color,
    hintText,
    this.onChanged,
  })  : this.color = color == null ? fff_colors.lightGray : color,
        this.hintText = hintText == null ? "Search" : hintText;

  @override
  _SearchBarState createState() => _SearchBarState(
      color: this.color, hintText: this.hintText, onChanged: this.onChanged);
}

class _SearchBarState extends State<SearchBar> {
  final Color color;
  final String hintText;
  final void Function(String) onChanged;

  _SearchBarState({
    this.color,
    this.hintText,
    this.onChanged,
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
          Expanded(
            child: Container(
              child: Material(
                child: TextField(
                  onChanged: this.onChanged,
                  style: Theme.of(context).textTheme.body1,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.only(left: 5),
                    fillColor: this.color,
                    filled: true,
                    hintText: this.hintText,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../utils/colors.dart' as fff_colors;

// Widget a check box which is either a check mark or an
class CheckBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: fff_colors.lightGray,
        borderRadius: BorderRadius.circular(5.0),
      ),
      height: 20.0,
      width: 20.0,
      child: Container(
        margin: const EdgeInsets.all(2.5),
        child: Image.asset(
          "assets/images/green-check.png",
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

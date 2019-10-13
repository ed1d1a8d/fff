import 'package:flutter/material.dart';
import '../utils/colors.dart' as fff_colors;

// Widget: stateless checkbox with customizable checked, unchecked, and null states
class FFFCheckBox extends StatelessWidget {
  final String checkedAssetName;
  final String uncheckedAssetName;
  final String nullAssetName;
  final bool checked;
  final onTap;

  FFFCheckBox({
    checkedAssetName,
    uncheckedAssetName,
    nullAssetName,
    this.checked,
    this.onTap,
  })  : this.checkedAssetName = checkedAssetName == null
            ? "assets/images/green-check.png"
            : checkedAssetName,
        this.uncheckedAssetName = uncheckedAssetName == null
            ? "assets/images/plus-sign.png"
            : uncheckedAssetName,
        this.nullAssetName = nullAssetName == null
            ? "assets/images/minus-sign.png"
            : nullAssetName;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => this.onTap(),
      child: Container(
        decoration: BoxDecoration(
          color: fff_colors.lightGray,
          borderRadius: BorderRadius.circular(5),
        ),
        height: 25,
        width: 25,
        child: Container(
          margin: const EdgeInsets.all(5),
          child: Image.asset(
            this.checked == null
                ? this.nullAssetName
                : (this.checked
                    ? this.checkedAssetName
                    : this.uncheckedAssetName),
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../utils/colors.dart' as fff_colors;

// Widget for a box outline with white background in the middle. The outline is a gradient.
class GradientContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry margin;

  const GradientContainer({
    this.child,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      margin: this.margin,
      decoration: BoxDecoration(
        color: Colors.black,
        gradient: new LinearGradient(
          colors: [fff_colors.gradientTop, fff_colors.gradientBottom],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(1.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: this.child,
        ),
      ),
    );
  }
}

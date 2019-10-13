import "package:flutter/material.dart";

// Widget for a box outline with white background in the middle. The outline is a gradient.
class URLAvatar extends StatelessWidget {
  final String imageURL;
  final double radius;

  const URLAvatar({
    @required this.imageURL,
    radius,
  }) : this.radius = radius == null ? 22 : radius;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: this.radius,
      backgroundImage: new NetworkImage(this.imageURL),
    );
  }
}

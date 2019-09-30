import 'package:flutter/material.dart';

class FillerWidget extends StatelessWidget {
 final Color color;

 FillerWidget(this.color);

 @override
 Widget build(BuildContext context) {
   return Container(
     color: color,
   );
 }
}
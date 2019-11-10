import "package:fff/backend/fff_timer.dart" as fff_backend_timer;
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";

class FFFTimerTuner extends StatelessWidget {
  final bool showText;

  FFFTimerTuner(this.showText);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = <Widget>[
      Container(
        color: Colors.transparent,
        width: 300,
        height: 200,
        child: CupertinoTimerPicker(
          mode: CupertinoTimerPickerMode.hms,
          minuteInterval: 1,
          initialTimerDuration: fff_backend_timer.getRemainingDuration(),
          onTimerDurationChanged: (Duration newDuration) {
            // TODO: Make a button to update time.
            fff_backend_timer
                .setExpirationTime(DateTime.now().add(newDuration));
          },
        ),
      ),
    ];

    if (this.showText) {
      widgets.addAll([
        SizedBox(height: 20),
        Text(
          "This allows friends to request food with you for the next few minutes.",
          style: Theme.of(context).textTheme.body1,
        ),
        SizedBox(height: 14),
        Text(
          "The timer will continue to run even when you are not in the app.",
          style: Theme.of(context).textTheme.body1,
        ),
      ]);
    }

    return Container(
      height: this.showText ? 330 : null,
      child: Column(
        children: widgets,
      ),
    );
  }
}

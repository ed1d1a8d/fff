import "dart:developer";

import "package:fff/backend/fff_timer.dart" as fff_backend_timer;
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";

class FFFTimerTuner extends StatefulWidget {
  final bool showText;

  FFFTimerTuner(this.showText);

  @override
  State<StatefulWidget> createState() => _FFFTimerTunerState();
}

class _FFFTimerTunerState extends State<FFFTimerTuner> {
  Duration _duration;

  @override
  void initState() {
    super.initState();
    _duration = fff_backend_timer.getRemainingDuration();
    log("Initialized _FFFTimerTunerState");
  }

  @override
  void dispose() {
    // TODO: Make an actual button to update duration, not just update on dispose
    fff_backend_timer.setExpirationTime(DateTime.now().add(_duration));
    super.dispose();
  }

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
          initialTimerDuration: _duration,
          onTimerDurationChanged: (Duration newDuration) {
            _duration = newDuration;
          },
        ),
      ),
    ];

    if (widget.showText) {
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
      height: widget.showText ? 330 : null,
      child: Column(
        children: widgets,
      ),
    );
  }
}

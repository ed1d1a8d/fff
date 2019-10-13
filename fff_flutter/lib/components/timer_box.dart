import "dart:async";
import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";

class TimerBox extends StatefulWidget {
  final Duration originalTimerDuration;

  TimerBox(originalTimerDuration)
      : this.originalTimerDuration = originalTimerDuration == null
            ? new Duration()
            : originalTimerDuration;

  @override
  State<StatefulWidget> createState() =>
      _TimerBoxState(this.originalTimerDuration);
}

class _TimerBoxState extends State<TimerBox> {
  Timer _timer;
  Duration timerDuration;

  _TimerBoxState(this.timerDuration) {
    this.startTimer();
  }

  void pauseTimer() {
    _timer.cancel();
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(oneSec, (Timer timer) {
      if (this.mounted)
        setState(
          () {
            if (timerDuration.inSeconds < 1) {
              timer.cancel();
            } else {
              timerDuration = timerDuration - Duration(seconds: 1);
            }
          },
        );
    });
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Countdown Timer"),
          content: Container(
              // Container to specify Alert Size
              height: 330,
              child: Column(
                children: <Widget>[
                  Container(
                    width: 300,
                    height: 200,
                    child: CupertinoTimerPicker(
                      mode: CupertinoTimerPickerMode.hms,
                      minuteInterval: 1,
                      initialTimerDuration: this.timerDuration,
                      onTimerDurationChanged: (Duration changedTimer) {
                        setState(() {
                          timerDuration = changedTimer;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                      "This allows friends to request food with you for the next ___ minutes.",
                      style: Theme.of(context).textTheme.body1),
                  SizedBox(height: 14),
                  Text(
                      "The timer will continue to run even when you are not in the app.",
                      style: Theme.of(context).textTheme.body1),
                ],
              )),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Set"),
              onPressed: () {
                startTimer();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.orange,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          Positioned.fill(
              child: Align(
                  alignment: Alignment.center,
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 1, 0, 0),
                      child: Text(
                        this.timerDuration.toString().substring(0, 7),
                        style: TextStyle(fontSize: 14),
                      )))),
        ],
      ),
      onTap: () {
        _showDialog();
      },
    );
  }
}

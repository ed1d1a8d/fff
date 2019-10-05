import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';

class TimerBox extends StatefulWidget {
  Duration timerDuration = new Duration();

  TimerBox(this.timerDuration);

  @override
  State<StatefulWidget> createState() {
    return _TimerBoxState();
  }
}

class _TimerBoxState extends State<TimerBox> {
  Timer _timer;

  void pauseTimer() {
    _timer.cancel();
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (this.mounted)
        setState(
              () {
            if (widget.timerDuration.inSeconds < 1) {
              timer.cancel();
            } else {
              widget.timerDuration = widget.timerDuration - Duration(seconds: 1);
            }
          },
        );
      }
    );
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
                      initialTimerDuration: widget.timerDuration,
                      onTimerDurationChanged: (Duration changedTimer) {
                        setState(() {
                          widget.timerDuration = changedTimer;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                      "This allows friends to request food with you for the next ___ minutes."),
                  SizedBox(height: 14),
                  Text(
                      "The timer will continue to run even when you are not in the app."),
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
                        widget.timerDuration.toString().substring(0, 7),
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

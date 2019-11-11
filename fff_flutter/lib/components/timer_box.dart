import "dart:async";
import "dart:developer";

import "package:fff/backend/fff_timer.dart" as fff_backend_timer;
import "package:fff/components/fff_timer_tuner.dart";
import "package:fff/utils/no_delay_periodic_timer.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";

class TimerBox extends StatefulWidget {
  final Function expiredCallback;

  TimerBox(Function this.expiredCallback);

  @override
  State<StatefulWidget> createState() => _TimerBoxState();
}

class _TimerBoxState extends State<TimerBox> {
  //  31.25 FPS Refresh
  static const Duration _timerRefreshPeriod = const Duration(milliseconds: 32);

  Timer _internalTimer;
  String _remainingDurationText = "";

  String _durationToText(Duration duration) =>
      duration.toString().split('.').first.padLeft(8, "0");

  @override
  initState() {
    super.initState();
    _internalTimer =
        noDelayPeriodicTimer(_timerRefreshPeriod, _handleInternalTimerUpdate);
    log("Initialized _TimerBoxState.");
  }

  @override
  dispose() {
    _internalTimer.cancel();
    super.dispose();
  }

  void _handleInternalTimerUpdate() async {
    if (fff_backend_timer.hasExpired()) {
      widget.expiredCallback();
    }
    final newDuration = fff_backend_timer.getRemainingDuration();
    setState(() {
      _remainingDurationText = _durationToText(newDuration);
    });
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Free (For Food) Timer"),
          content: FFFTimerTuner(true),
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
                  _remainingDurationText,
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ),
          ),
        ],
      ),
      onTap: () {
        _showDialog();
      },
    );
  }
}

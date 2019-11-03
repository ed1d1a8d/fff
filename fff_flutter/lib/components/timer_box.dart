import "dart:async";
import "dart:developer";

import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";

class TimerBox extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TimerBoxState();

  // this function is only useful during its first call
  static void setInitialDuration(Duration newDuration) {
    _TimerBoxState.setInitialDuration(newDuration);
  }

  // this function just sets the duration of the timer to a new value regardless
  static void setDuration(Duration newDuration) {
    _TimerBoxState.setDuration(newDuration);
  }
}

class _TimerBoxState extends State<TimerBox> {
  static const Duration _oneSecond = const Duration(seconds: 1);

  // all variables here static because we only want one TimerBox per app
  static Duration _timerDuration;
  static Timer _internalTimer;

  // this variable determines if the timer is visible rn
  static _TimerBoxState _mountedInstance;

  _TimerBoxState() {
    log("Initialized new _TimerBoxState.");
    _TimerBoxState._mountedInstance = this;

    // internal timer should only be set once
    // what it does is controlled by other static variables
    if (_TimerBoxState._internalTimer == null) {
      _TimerBoxState._internalTimer = new Timer.periodic(
          _TimerBoxState._oneSecond, _TimerBoxState._handleInternalTimer);
    }
  }

  @override
  dispose() {
    _TimerBoxState._mountedInstance = null;
    super.dispose();
  }

  static void _handleInternalTimer(Timer timer) {
    // don't do anything if the duration is too small
    if (_TimerBoxState._timerDuration.inSeconds >= 1) {
      _TimerBoxState.setDuration(
          _TimerBoxState._timerDuration - _TimerBoxState._oneSecond);
    }
  }

  // set new duration for the timer and handle everything associated with it
  static void setDuration(Duration newDuration) {
    Function makeDurationChange = () {
      _TimerBoxState._timerDuration = newDuration;
    };

    // only setstate when an instance of this state is mounted
    if (_TimerBoxState._mountedInstance == null) {
      makeDurationChange();
    } else {
      _TimerBoxState._mountedInstance.setState(makeDurationChange);
    }
  }

  // set a new duration only if the duration now is null
  static void setInitialDuration(Duration newDuration) {
    if (_TimerBoxState._timerDuration == null) {
      _TimerBoxState.setDuration(newDuration);
    }
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Free (For Food) Timer"),
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
                    initialTimerDuration: _TimerBoxState._timerDuration,
                    onTimerDurationChanged: (Duration newDuration) {
                      _TimerBoxState.setDuration(newDuration);
                    },
                  ),
                ),
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
              ],
            ),
          ),
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
                  _TimerBoxState._timerDuration.toString().substring(0, 7),
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

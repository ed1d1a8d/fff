import "dart:async";
import "dart:developer";

import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";

class TimerBox extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TimerBoxState();

  // this function just sets the duration of the timer to a new value regardless
  static void setExpirationTime(DateTime newExpirationTime) {
    _TimerBoxState.setExpirationTime(newExpirationTime);
  }
}

class _TimerBoxState extends State<TimerBox> {
  static const Duration _oneSecond = const Duration(seconds: 1);

  // all variables here static because we only want one TimerBox per app
  static DateTime _expirationTime;
  static Timer _internalTimer;

  // this variable determines if the timer is visible rn
  static Set<_TimerBoxState> _mountedInstances = Set();

  _TimerBoxState() {
    log("Initialized new _TimerBoxState.");
    _TimerBoxState._mountedInstances.add(this);

    // internal timer should only be set once
    // what it does is controlled by other static variables
    if (_TimerBoxState._internalTimer == null) {
      _TimerBoxState._internalTimer = new Timer.periodic(
          _TimerBoxState._oneSecond, _TimerBoxState._handleInternalTimer);
    }
  }

  @override
  dispose() {
    _TimerBoxState._mountedInstances.remove(this);
    super.dispose();
  }

  static void _handleInternalTimer(Timer timer) {
    // if the timer has expired
    if (_TimerBoxState.durationToExpiration().inMilliseconds == 0) {
      // pop up an expiration screen
      log("Timer expired!");
    } else {
      // only setstate when an instance of this state is mounted
      for (_TimerBoxState instance in _TimerBoxState._mountedInstances) {
        instance.setState((){});
      }
    }
  }

  // set new duration for the timer and handle everything associated with it
  static void setExpirationTime(DateTime newExpirationTime) {
    _TimerBoxState._expirationTime = newExpirationTime;
  }

  // return 0 if expiration has passed - otherwise, duration to expiration
  static Duration durationToExpiration() {
    DateTime now = new DateTime.now();
    if (now.isAfter(_TimerBoxState._expirationTime)) {
      return new Duration();
    }
    return _TimerBoxState._expirationTime.difference(now);
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
                    initialTimerDuration: _TimerBoxState.durationToExpiration(),
                    onTimerDurationChanged: (Duration newDuration) {
                      // update the expiration time?
                      log("TODO");
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
                  _TimerBoxState.durationToExpiration().toString().substring(0, 7),
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

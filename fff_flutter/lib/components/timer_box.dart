import "dart:async";
import "dart:developer";

import "package:fff/routes.dart" as fff_routes;
import "package:fff/backend/fff_timer.dart" as fff_timer_backend;
import "package:fff/components/fff_timer_tuner.dart";
import "package:fff/views/fff_timer_expired.dart";
import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";

class TimerBox extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TimerBoxState();

  // this function just sets the duration of the timer to a new value regardless
  static void setExpirationTime(DateTime newExpirationTime) {
    _TimerBoxState.setExpirationTime(newExpirationTime);
  }

  static Duration durationToExpiration() {
    return _TimerBoxState.durationToExpiration();
  }

  // update both the backend and frontend with an expiry time
  // should not have race conditions with all other places where this is called
  static void queueSimulataneousExpirationUpdate(DateTime newExpirationTime) {
    _TimerBoxState._expirationTimePendingUpdate = newExpirationTime;
    if (!_TimerBoxState._backendUpdating) {
      _TimerBoxState._backendUpdating = true;
      _TimerBoxState.simultaneousUpdate();
    }
  }

  static void setGlobalContextFromMain(BuildContext context) {
    _TimerBoxState._globalContext = context;
  }
}

class _TimerBoxState extends State<TimerBox> {
  static const Duration _oneSecond = const Duration(seconds: 1);

  // all variables here static because we only want one TimerBox per app
  static DateTime _expirationTime;
  static Timer _internalTimer;

  // this variable determines if the timer is visible rn
  static Set<_TimerBoxState> _mountedInstances = Set();

  // backend request in progress from timer adjuster
  static bool _backendUpdating = false;
  static DateTime _expirationTimePendingUpdate;

  // global context, set by main, used to push the expired page when needed
  static BuildContext _globalContext;

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

  static bool _hasExpired() {
    return _TimerBoxState.durationToExpiration().inMilliseconds == 0;
  }

  static void _handleInternalTimer(Timer timer) {
    // if the timer has expired
    if (_TimerBoxState._hasExpired()) {
      // only transition if we haven't already yet; this internal timer doesn't get stopped, ever
      if (!FFFTimerExpired.mounted) {
        FFFTimerExpired.mounted = true;

        // pop up an expiration screen
        log("FFF Timer expired! Transitioning to expired view with context + " +
            _TimerBoxState._globalContext.toString() +
            ".");
        Navigator.pushReplacementNamed(
            _TimerBoxState._globalContext, fff_routes.fffTimerExpired);
      }
    } else {
      // only setstate when an instance of this state is mounted
      for (_TimerBoxState instance in _TimerBoxState._mountedInstances) {
        instance.setState(() {});
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

  static void simultaneousUpdate() {
    DateTime newExpirationTime = _TimerBoxState._expirationTimePendingUpdate;
    _TimerBoxState._expirationTimePendingUpdate = null;
    fff_timer_backend.setExpirationTime(newExpirationTime).then((_) {
      TimerBox.setExpirationTime(newExpirationTime);

      // trigger another simultaneous update if _expirationTimePendingUpdate has been set again
      if (_TimerBoxState._expirationTimePendingUpdate != null) {
        _TimerBoxState.simultaneousUpdate();
      } else {
        _TimerBoxState._backendUpdating = false;
      }
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
                  _TimerBoxState.durationToExpiration()
                      .toString()
                      .substring(0, 7),
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

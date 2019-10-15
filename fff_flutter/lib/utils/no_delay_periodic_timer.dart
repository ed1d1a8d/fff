import "dart:async";

/// Fires callback immediately and initiates and returns a periodic timer.
Timer noDelayPeriodicTimer(Duration period, Function() callback) {
  Timer.run(callback);
  return new Timer.periodic(period, (_) => callback());
}

import 'dart:async';

class TimerManager {
  Timer? timer;
  final Duration interval;
  final Function callback;

  TimerManager({required this.interval, required this.callback});

  void start() {
    // Clear the previous timer
    timer?.cancel();

    // Start a new timer
    timer = Timer.periodic(interval, (timer) {
      callback();
    });
  }

  void stop() {
    timer?.cancel();
  }
}

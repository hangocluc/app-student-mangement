class TimeModel {
  final int hour;
  final int minute;
  final int? second;

  TimeModel({required this.hour, required this.minute, this.second});

  TimeModel copyWith({
    int? hour,
    int? minute,
    int? second,
  }) {
    return TimeModel(
      hour: hour ?? this.hour,
      minute: minute ?? this.minute,
      second: second ?? this.second,
    );
  }

  @override
  String toString() =>
      'TimeModel(hour: $hour, minute: $minute, second: $second)';

  String toStringmmSS() {
    if (toMinute() > 0) {
      return '$hour時間 $minute分';
    } else {
      return '';
    }
  }

  String toStringWithSpace() {
    if (toMinute() > 0) {
      return '$hour時間 $minute分';
    } else {
      return '0時間 0分';
    }
  }

  int toMinute() {
    return hour * 60 + minute;
  }

  int toSecond() {
    return hour * 60 * 60 + minute * 60 + (second ?? 0);
  }

  toHHMMSS() {
    String hh = hour.toString().padLeft(2, '0');
    String mm = minute.toString().padLeft(2, '0');
    String ss = second.toString().padLeft(2, '0');

    return '$hh:$mm:$ss';
  }

  static double convertTimeToDouble(TimeModel time) {
    // String timeString = '${time.hour}.${time.minute}';
    // return double.parse(timeString);

    return time.hour + (time.minute / 60);
  }

  static TimeModel fromDouble(dynamic value) {
    final valueToDouble = double.tryParse(value.toString()) ?? 0;
    final hour = valueToDouble.floor();
    final minute = ((valueToDouble - hour.toDouble()) * 60).round();
    return TimeModel(hour: hour, minute: minute);
  }

  static TimeModel fromMinute(int value) {
    final hour = value ~/ 60;
    final minute = value % 60;
    return TimeModel(hour: hour, minute: minute);
  }

  static TimeModel fromMinuteDouble(dynamic value) {
    final hour = value.floor();

    final minute = ((value - hour) * 10).round();

    return TimeModel(hour: hour, minute: minute);
  }

  static TimeModel fromHour(double value) {
    final hour = value.floor();
    final minute = ((value - hour) * 60).ceil();
    return TimeModel(hour: hour, minute: minute);
  }

  static TimeModel fromHHMMSS(String value) {
    List<String> parts = value.split(':');

    int hour = 0;
    int minute = 0;
    int second = 0;

    if (parts.length == 3) {
      // hh:mm:ss
      hour = int.tryParse(parts[0]) ?? 0;
      minute = int.tryParse(parts[1]) ?? 0;
      second = int.tryParse(parts[2]) ?? 0;
    } else if (parts.length == 2) {
      // mm:ss
      minute = int.tryParse(parts[0]) ?? 0;
      second = int.tryParse(parts[1]) ?? 0;
    } else if (parts.length == 1) {
      // ss
      second = int.tryParse(parts[0]) ?? 0;
    }
    return TimeModel(hour: hour, minute: minute, second: second);
  }
}

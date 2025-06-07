import 'package:intl/intl.dart';

extension DateTimeEx on DateTime {
  bool isSameDay(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  DateTime calcDateIntervalDay(int intervalDay) {
    return add(Duration(days: intervalDay));
  }

  bool get isWithinDeadlineDayByNow {
    DateTime now = DateTime.now();
    DateTime limitDate = DateTime(year, month, day, 23, 59, 59);
    return limitDate.isAfter(now);
  }

  /// Ex: 2020/02/08
  String get convertStringYMD {
    return DateFormat('yyyy-MM-dd').format(this);
  }

  String get convertStringDYMD {
    return DateFormat('yyyy/MM/dd').format(this);
  }

  /// Ex: 2020/02/08 11:48:53
  String get convertStringYMDHMS {
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(this);
  }

  /// Ex: 2020/02/08T11:48:53
  String get convertStringYMDTHMS {
    return DateFormat('yyyy-MM-ddTHH:mm:ss').format(this);
  }

  /// Ex: 2020/02/08T11:48:53
  String get convertStringYMDTHMSZ {
    return DateFormat('yyyy-MM-ddTHH:mm:ssZ').format(this);
  }

  /// Ex: 1985年08月15日
  String get convertStringJapanType {
    return DateFormat('yyyy年MM月dd日').format(this);
  }

  // Ex:2025年08月31日 (日) 23：59まで
  String get convertStringJapanFullTimeType {
    return DateFormat('yyyy年MM月dd日 (日) HH：mmまで').format(this);
  }

  String get convertStringMMDD {
    return DateFormat('MM/dd').format(this);
  }

  String get toMonth {
    return DateFormat('yyyy-MM').format(this);
  }

  String get toTime {
    return DateFormat('HH:mm').format(this);
  }

  String getRangeWithOtherDate(DateTime value) {
    DateTime before = this;
    DateTime after = value;
    if (value.isBefore(this)) {
      before = value;
      after = this;
    }
    if (before.year == after.year) {
      return '${before.year}年${before.month}月～${after.month}月';
    } else {
      return '${before.year}年${before.month}月～${after.year}年${after.month}月';
    }
  }

  String getRangeWithOtherDateTime(DateTime value) {
    String getJapaneseWeekday(int weekday) {
      const weekdays = ['月', '火', '水', '木', '金', '土', '日'];
      return weekdays[weekday - 1];
    }

    final startDate = DateFormat('y年M月d日').format(this);
    final startWeekday = getJapaneseWeekday(weekday);
    final startTime = DateFormat('H：mm').format(this);

    final endDate = DateFormat('y年M月d日').format(value);
    final endWeekday = getJapaneseWeekday(value.weekday);
    final endTime = DateFormat('H：mm').format(value);

    return '$startDate（$startWeekday）$startTime～\n$endDate（$endWeekday）$endTimeまで';
  }
}

extension DateTimeNullSafetyEx on DateTime? {
  bool isSameDay(DateTime other) {
    if (this == null) {
      return false;
    } else {
      return this!.year == other.year &&
          this!.month == other.month &&
          this!.day == other.day;
    }
  }

  DateTime? calcDateIntervalDay(int intervalDay) {
    if (this == null) {
      return null;
    }
    return this!.add(Duration(days: intervalDay));
  }

  /// Ex: 2020/02/08
  String? get convertStringYMD {
    if (this == null) {
      return null;
    }
    return DateFormat('yyyy-MM-dd').format(this!);
  }

  /// Ex: 2020/02/08 11:48:53
  String? get convertStringYMDHMS {
    if (this == null) {
      return null;
    }
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(this!);
  }

  /// Ex: 2020/02/08T11:48:53
  String? get convertStringYMDTHMS {
    if (this == null) {
      return null;
    }
    return DateFormat('yyyy-MM-ddTHH:mm:ss').format(this!);
  }

  /// Ex: 1985年08月15日
  String? get convertStringJapanType {
    if (this == null) {
      return null;
    }
    return DateFormat('yyyy年MM月dd日').format(this!);
  }

  // Ex:2025年08月31日 (日) 23：59まで
  String get convertStringJapanFullTimeType {
    if (this == null) {
      return '';
    }
    return DateFormat('yyyy年MM月dd日 (日) HH：mmまで').format(this!);
  }

  String? get convertStringMMDD {
    if (this == null) {
      return null;
    }
    return DateFormat('MM/dd').format(this!);
  }

  String get toMonth {
    if (this == null) {
      return '';
    }
    return DateFormat('yyyy-MM').format(this!);
  }

  String get toTime {
    if (this == null) {
      return '';
    }
    return DateFormat('HH:mm').format(this!);
  }

  String getRangeWithOtherDate(DateTime? value) {
    if (this == null || value == null) {
      return '';
    }
    DateTime before = this!;
    DateTime after = value;
    if (value.isBefore(this!)) {
      before = value;
      after = this!;
    }
    if (before.year == after.year) {
      return '${before.year}年${before.month}月～${after.month}月';
    } else {
      return '${before.year}年${before.month}月～${after.year}年${after.month}月';
    }
  }

  toStartTimeOfDay() {
    if (this == null) {
      return null;
    }
    return DateTime(this!.year, this!.month, this!.day, 0, 0, 0);
  }

  toEndMorningTimeOfDay() {
    if (this == null) {
      return null;
    }
    return DateTime(this!.year, this!.month, this!.day, 11, 59, 59);
  }

  toEndTimeOfDay() {
    if (this == null) {
      return null;
    }
    return DateTime(this!.year, this!.month, this!.day, 23, 59, 59);
  }
}

extension StringEx on String {
  String formatJapaneseDay() {
    // Parse the input date string
    DateTime date = DateTime.parse(this);

    // Format the date to "11月16日"
    String formattedDate = DateFormat.MMMd('ja').format(date);

    // Get the day of the week in Japanese
    String dayOfWeek = DateFormat.E('ja').format(date);

    // Combine the formatted date and day of the week
    return '$formattedDate（$dayOfWeek）';
  }

  String formatJapaneseMonthYear() {
    // Parse the input date string
    DateTime date = DateTime.parse(this);

    // Format the date to "yyyy年MM月"
    final DateFormat formatter = DateFormat('yyyy年MM月', 'ja_JP');
    return formatter.format(date);
  }

  String formatJapaneseMonth() {
    // Parse the input date string
    DateTime date = DateTime.parse(this);

    // Format the date to "yyyy年MM月"
    final DateFormat formatter = DateFormat('M');
    return formatter.format(date);
  }

  String formatJapaneseYYYYMMDD() {
    // Parse the input date string
    DateTime date = DateTime.parse(this);

    // Format the date to "yyyy年MM月"
    final DateFormat formatter = DateFormat('yyyy年MM月dd日', 'ja_JP');
    return formatter.format(date);
  }
}

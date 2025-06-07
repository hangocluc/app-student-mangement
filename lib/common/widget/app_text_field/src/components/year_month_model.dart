class YearMonthModel {
  dynamic year;
  dynamic month;

  YearMonthModel({
    required this.year,
    required this.month,
  });

  YearMonthModel copyWith({
    dynamic year,
    dynamic month,
  }) {
    return YearMonthModel(
      year: year ?? this.year,
      month: month ?? this.month,
    );
  }

  String toStringDate() {
    if (year != null) {
      return '$year年$month月';
    } else {
      return '';
    }
  }

  static DateTime? fromDynamicToDateTime({
    dynamic year,
    dynamic month,
  }) {
    if (year != null || month != null) {
      return DateTime(
        year,
        month,
      );
    }
    return null;
  }

  YearMonthModel dateTimeInit({dynamic year, dynamic month, dynamic day}) {
    return YearMonthModel(
      year: year ?? DateTime.now().year,
      month: month ?? DateTime.now().month,
    );
  }
}

class DateModel {
  dynamic year;
  dynamic month;
  dynamic day;

  DateModel({required this.year, required this.month, required this.day});

  DateModel copyWith({
    dynamic year,
    dynamic month,
    dynamic day,
  }) {
    return DateModel(
        year: year ?? this.year,
        month: month ?? this.month,
        day: day ?? this.day);
  }

  String toStringDate() {
    if (year != null) {
      return '$year年$month月$day日';
    } else {
      return '';
    }
  }

  static DateTime? fromDynamicToDateTime(
      {dynamic year, dynamic month, dynamic day}) {
    if (year != null || month != null || day != null) {
      return DateTime(year, month, day);
    }
    return null;
  }

  DateModel dateTimeInit({dynamic year, dynamic month, dynamic day}) {
    return DateModel(
        year: year ?? DateTime.now().year,
        month: month ?? DateTime.now().month,
        day: day ?? DateTime.now().day);
  }

// static double convertStringToDouble(DateModel bodyIndex) {
//   String bodyIndexString = '${bodyIndex.integerPart}.${bodyIndex.decimal}';
//   return double.parse(bodyIndexString);
// }
//
// static DateModel fromBodyIndexDouble(dynamic value) {
//   double doubleValue = value.toDouble();
//
//   dynamic integerPart = doubleValue.floor();
//   dynamic decimalPart = ((doubleValue - integerPart) * 10).round();
//
//   return DateModel(integerPart: integerPart, decimal: decimalPart);
// }
}

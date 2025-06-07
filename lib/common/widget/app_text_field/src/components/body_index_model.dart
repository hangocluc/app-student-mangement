class BodyIndexModel {
  dynamic integerPart;
  dynamic decimal;

  BodyIndexModel({required this.integerPart, required this.decimal});

  BodyIndexModel copyWith({
    dynamic integerPart,
    dynamic decimal,
  }) {
    return BodyIndexModel(
        integerPart: integerPart ?? this.integerPart,
        decimal: decimal ?? this.decimal);
  }

  String toStringBodyIndex() {
    if (integerPart > 0) {
      return '$integerPart.$decimal';
    } else {
      return '';
    }
  }

  static double convertStringToDouble(BodyIndexModel bodyIndex) {
    String bodyIndexString = '${bodyIndex.integerPart}.${bodyIndex.decimal}';
    return double.parse(bodyIndexString);
  }

  static BodyIndexModel fromBodyIndexDouble(dynamic value) {
    double doubleValue;
    doubleValue = double.tryParse(value.toString()) ?? 0;
    dynamic integerPart = doubleValue.floor();
    dynamic decimalPart = ((doubleValue - integerPart) * 10).round();

    return BodyIndexModel(integerPart: integerPart, decimal: decimalPart);
  }
}

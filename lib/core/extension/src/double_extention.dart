extension DoubleExtension on double? {
  bool get isNullOrZero {
    return (this == 0 || this == null);
  }

  bool get isNull {
    return this == null;
  }
}

extension BoolExtention on bool? {
  bool get convertValueTrue {
    return this ?? true;
  }

  bool get convertValueFalse {
    return this ?? false;
  }

  int get toInt {
    return this == true ? 1 : 0;
  }
}

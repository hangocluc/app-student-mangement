extension ListExtension on List? {
  bool get isEmptyOrNull {
    if (this == null) {
      return true;
    }

    return this!.isEmpty;
  }
}

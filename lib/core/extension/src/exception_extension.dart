extension ErrorExtension on Exception {
  String get message {
    if (toString().contains("DioException")) {
      final result = toString().replaceFirst(":", "@_@_@").split("@_@_@").last;
      return result;
    }
    return toString().replaceAll("Exception:", "");
  }
}

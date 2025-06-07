import 'dart:ui';

import 'package:intl/intl.dart';

extension StringExtension on String? {
  bool get isNullOrEmpty => this == null || this == '';

  bool get isNotNullOrEmpty => this != null && this != '';

  String get orEmpty => this ?? '';

  bool get isValidEmail {
    final regex = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');
    return regex.hasMatch(this ?? '');
  }

  DateTime? get convertToDateTime {
    if (this == null) {
      return null;
    }

    final tmp = this!.replaceAll('/', '-');

    List<String> formats = [
      'yyyy-MM-ddTHH:mm:ssZ',
      'yyyy-MM-ddTHH:mm:ss',
      'yyyy-MM-dd HH:mm:ss',
      'yyyy-MM-dd HH:mm',
      'yyyy-MM-dd',
    ];

    try {
      for (String format in formats) {
        try {
          final dateTime = DateFormat(format).parse(tmp);
          return dateTime;
        } catch (e) {
          continue;
        }
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  /// Ex: 2020/02/08 14:08
  String get convertTimeString {
    if (this == null) {
      return '';
    }
    final dateTime = DateFormat('yyyy-MM-dd HH:mm:ss').parse(this!);
    return DateFormat('yyyy/MM/dd HH:mm').format(dateTime);
  }

  DateTime get convertToDateTime2 {
    if (this == null) return DateTime.now();

    final tmp = this!.replaceAll('/', '-');
    final dateTime = DateFormat('yyyy-MM-dd HH:mm:ss').parse(tmp);

    return dateTime;
  }

  List<String> get searchTextList {
    if (this == null) return [];

    return toString()
        .replaceAll("　", " ")
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim()
        .split(" ");
  }

  List<String> get extractURLsFromString {
    const regex = r"(http://|https://){1}[\w\.\-/:#\?=\&;%~+]+";
    final urls = RegExp(regex, caseSensitive: false)
        .allMatches(this ?? '')
        .map((match) => match.group(0) ?? '')
        .toList();
    return urls;
  }

  String get ext {
    if (this == null) return '';

    return this!.split('.').last.trim().toLowerCase();
  }

  String get convertValue {
    return this ?? '';
  }

  Color? get fromHex {
    if (this == null) return null;
    final buffer = StringBuffer();
    if (this!.length == 6 || this!.length == 7) buffer.write('FF');
    buffer.write(this!.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  bool isMatchPattern(String pattern) {
    if (this != null) {
      return RegExp(pattern).hasMatch(this!);
    }
    return false;
  }

  bool isHTML() {
    final RegExp htmlRegExp =
        RegExp('<[^>]*>', multiLine: true, caseSensitive: false);
    return htmlRegExp.hasMatch(this ?? '');
  }

  String toHtmlTag() {
    return '<a href=\'$this\'>$this</a>';
  }
}

String messageFromException(dynamic exception) {
  if (exception.toString().contains("DioException")) {
    final result =
        exception.toString().replaceFirst(":", "@_@_@").split("@_@_@").last;
    return result;
  }
  return exception.toString().replaceAll("Exception:", "");
}

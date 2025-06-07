import 'dart:math';

extension IntExtension on int? {
  bool get isNullOrZero {
    return (this == 0 || this == null);
  }

  String get convertToNotice {
    if (this == null) return '';

    if (this! > 9) return '9+';

    return this!.toString();
  }

  int get convertValue {
    if (this == null) return 0;

    return this!;
  }

  String get getFileSizeString {
    if (this == null) return '';
    const suffixes = [" B", " KB", " MB", " GB", " TB"];
    if (this == 0) return '0${suffixes[0]}';
    var i = (log(this!) / log(1024)).floor();
    return ((this! / pow(1024, i)).toStringAsFixed(1)) + suffixes[i];
  }

  String get formatByteSize {
    if (this == null) return '';
    if (this! <= 0) {
      return '';
    }

    List<String> units = ['B', 'KB', 'MB', 'GB', 'TB'];
    int i = 0;
    int div = 1;
    while (this! / div >= 1024) {
      div *= 1024;
      i++;
    }
    int t = (this! * 10 / div).round();
    return '${t ~/ 10}.${t % 10} ${units[i]}';
  }

  String get toRomanNumber {
    switch (this) {
      case 0:
        return '0';
      case 1:
        return 'I';
      case 2:
        return 'II';
      case 3:
        return 'III';
      case 4:
        return 'IV';
      case 5:
        return 'V';
      case 6:
        return 'VI';
      case 7:
        return 'VII';
      case 8:
        return 'VIII';
      case 9:
        return 'IX';
      case 10:
        return 'X';
      case 11:
        return 'XI';
      case 12:
        return 'XII';
      case 13:
        return 'XIII';
      case 14:
        return 'XIV';
      case 15:
        return 'XV';
      default:
        return '';
    }
  }

  bool isResponseSuccess() {
    if (this != null && this == 200) {
      return true;
    }
    return false;
  }
}

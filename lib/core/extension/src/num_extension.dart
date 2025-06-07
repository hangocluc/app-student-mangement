import 'package:intl/intl.dart';

extension NumExtension on num? {
  String get formatPrice {
    if (this == null) {
      return '';
    }
    final format = NumberFormat("###,###", "vi_VN");
    return format.format(this!);
  }

  String get formatPriceMillion {
    if (this == null) {
      return '';
    }
    final mil = this! / 1000000;
    final format = NumberFormat("###,###.#", "vi_VN");
    return format.format(mil);
  }
}

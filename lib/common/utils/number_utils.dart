import 'package:intl/intl.dart';

String formatIntWithCommas(int value) {
  return NumberFormat('#,###').format(value);
}

String formatDoubleWithComas(double value, {bool? autoConvertToInt}) {
  NumberFormat formatter = NumberFormat('#,###.########');

  if (autoConvertToInt == true) {
    if (value == value.toInt()) {
      return formatter.format(value.toInt());
    } else {
      return formatter.format(value);
    }
  } else {
    return formatter.format(value);
  }
}

import 'package:flutter/services.dart';

import '../constants/src/app_constants.dart';

class AppInputFormat {
  static var inputOnlyDigit =
      FilteringTextInputFormatter.allow(RegExp(r'[0-9]'));
  static var inputMaxLength = LengthLimitingTextInputFormatter(
      AppConstants.TEXTFIELD_MAX_LENGTH_COMMON);
}

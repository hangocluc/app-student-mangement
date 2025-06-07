import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../main.dart';

class ContactUtils {
  static void openEmail(String email, {String? subject, String? body}) async {
    String url = "mailto:$email?subject=$subject&body=$body";
    launchUrlString(url);
  }

  static String formattedNumber(int number) {
    String formattedNumber = NumberFormat('#,###').format(number);
    return formattedNumber;
  }
}

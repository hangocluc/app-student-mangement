import 'package:csv/csv.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'postal_code_info.dart';

class PostalCodeOtaUtils {
  static final PostalCodeOtaUtils _instance = PostalCodeOtaUtils._internal();
  static PostalCodeOtaUtils get instance => _instance;

  factory PostalCodeOtaUtils() {
    return _instance;
  }

  Future<void> initial() async {
    await _loadCSV();
  }

  PostalCodeOtaUtils._internal();

  final List<PostalCodeInfo> _postCodeOta = [];
  final List<String> _adressCanReceivePostCode = [
    '東京都',
    '茨城県',
    '神奈川県',
    '栃木県',
    '千葉県',
    '群馬県',
    '埼玉県',
    '山梨県'
  ];
  static const POST_CODE_LENGTH = 7;
  PostalCodeInfo? getAddress1ByPostCode(String postCode) {
    final postCodeConverted = convertPostCodeValue(postCode);
    if (postCodeConverted.length < POST_CODE_LENGTH) {
      return null;
    }
    try {
      final postCodeValid = _postCodeOta
          .where((element) => element.postCode == postCodeConverted);
      if (postCodeValid.isEmpty) {
        throw Exception();
      } else {
        return postCodeValid.first;
      }
    } catch (e) {
      return null;
    }
  }

  Future<void> _loadCSV() async {
    final rawData = await rootBundle.loadString("assets/csv/postal_code.csv");
    List<List<dynamic>> listData =
        const CsvToListConverter().convert(rawData, eol: '\n');
    _postCodeOta.clear();
    if (listData.isNotEmpty) {
      for (var element in listData) {
        final postalCode = PostalCodeInfo(element.elementAt(2).toString(),
            element.elementAt(6), element.elementAt(7), element.elementAt(8));
        _postCodeOta.add(postalCode);
      }
    }
  }

  bool canReceivePostCode(String city) {
    return _adressCanReceivePostCode.contains(city.trim());
  }

  static String convertPostCodeValue(String postCode) {
    return postCode
        .trim()
        .replaceAll('-', '')
        .replaceAll('.', '')
        .replaceAll('_', '')
        .replaceAll(' ', '');
  }
}

import 'package:equatable/equatable.dart';

abstract class DropdownModel extends Equatable {
  String getItemId();

  String getItemDisplay();

  String? getItemDescription();
}

List<CommonDropdownModel> genderSelections = [
  CommonDropdownModel(code: 'MALE', display: '男性'),
  CommonDropdownModel(code: 'FEMALE', display: '女性'),
  // CommonDropdownModel(code: 'OTHER', display: 'その他'),
  CommonDropdownModel(code: 'DO_NOT_ANSWER', display: '回答しない'),
];
List<CommonDropdownModel> subjectSelections = [
  CommonDropdownModel(code: "1", display: "アプリの不具合"),
  CommonDropdownModel(code: "2", display: "アプリに関する質問"),
  CommonDropdownModel(code: "3", display: "アカウント関連"),
  CommonDropdownModel(code: "4", display: "ご意見・ご感想"),
  CommonDropdownModel(code: "5", display: "その他"),
];
List<CommonDropdownModel> attibuteSelections = [
  CommonDropdownModel(code: 'RESIDENT', display: '大田区在住'),
  CommonDropdownModel(
      code: 'MIGRANT',
      display: '大田区在勤/在学',
      desciption: '※関東圏外、島しょ部にお住まいの方を除く。'),
  CommonDropdownModel(
      code: 'OTHER', display: 'その他', desciption: '※抽選に応募できません。'),
];

List<CommonDropdownModel> insuranceSelections = [
  CommonDropdownModel(code: 'SOCIAL_INSURANCE', display: '社会保険'),
  CommonDropdownModel(code: 'NATIONAL_HEALTH_INSURANCE', display: '国民健康保険'),
  CommonDropdownModel(
    code: 'MEDICAL_INSURANCE_FOR_THE_ELDERLY',
    display: '後期高齢者医療保険',
  ),
];
List<CommonDropdownModel> residenceSelections = [
  CommonDropdownModel(code: "Chofu", display: "調布地域"),
  CommonDropdownModel(code: "Kamata", display: "蒲田地域"),
  CommonDropdownModel(code: "Omori", display: "⼤森地域"),
  CommonDropdownModel(code: "KojiyaHaneda", display: "糀谷・羽田地域"),
  CommonDropdownModel(code: "Outside", display: "区外"),
];

List<CommonDropdownModel> filterResidenceSelections(
    String type, List<CommonDropdownModel> residenceSelections) {
  List<CommonDropdownModel> list =
      residenceSelections = List.from(residenceSelections);
  if (type == "RESIDENT") {
    list.removeWhere((item) => item.code == "Outside");
    return list;
  } else if (type == "MIGRANT" || type == "OTHER") {
    list.removeWhere((item) =>
        ["Chofu", "Kamata", "Omori", "KojiyaHaneda"].contains(item.code));
    return list;
  } else {
    return list;
  }
}

class CommonDropdownModel extends DropdownModel {
  final String code;
  final String display;
  final String? desciption;

  CommonDropdownModel(
      {required this.code, required this.display, this.desciption});

  @override
  String getItemDisplay() {
    return display;
  }

  @override
  String getItemId() {
    return code;
  }

  @override
  List<Object?> get props => [code];

  @override
  String? getItemDescription() {
    return desciption;
  }

  static CommonDropdownModel? getByCodeInList(
      List<CommonDropdownModel> models, String code) {
    try {
      final result = models
          .where(
            (element) => element.code == code,
          )
          .first;
      return result;
    } catch (error) {
      return null;
    }
  }
}

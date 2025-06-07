import 'package:equatable/equatable.dart';

abstract class RadioModel extends Equatable {
  String getItemId();

  String getItemDisplay();

  String? getItemDescription();

  int? getCodeToInt();
}

// HEALTH question register user info
CommonRadioQuestion healthAndFitnetQuestion1 = CommonRadioQuestion(
  number: 1,
  question: '現在のあなたの健康状態はいかがですか？',
  answers: healthAndFitnetAnswers1,
);
CommonRadioQuestion healthAndFitnetQuestion2 = CommonRadioQuestion(
  number: 2,
  question: '毎日の平均歩数を教えてください。\n（歩行時間10分で約1,000歩、歩行距離は600～700ｍ程度に相当します。)',
  answers: healthAndFitnetAnswers2,
);
CommonRadioQuestion healthAndFitnetQuestion3 = CommonRadioQuestion(
  number: 3,
  question: '現在、１日30分以上の軽く汗をかく運動をどのくらいの頻度で運動を行っていますか？',
  answers: healthAndFitnetAnswers3,
);
List<CommonRadioModel> healthAndFitnetAnswers1 = [
  CommonRadioModel(code: '1', display: 'とてもよい'),
  CommonRadioModel(code: '2', display: 'よい'),
  CommonRadioModel(code: '3', display: 'どちらともいえない'),
  CommonRadioModel(code: '4', display: 'あまりよくない'),
  CommonRadioModel(code: '5', display: 'よくない'),
];
List<CommonRadioModel> healthAndFitnetAnswers2 = [
  CommonRadioModel(code: '1', display: '10,000歩以上'),
  CommonRadioModel(code: '2', display: '8,000～9,999歩'),
  CommonRadioModel(code: '3', display: '6,000～7,999歩'),
  CommonRadioModel(code: '4', display: '4,000～5,999歩'),
  CommonRadioModel(code: '5', display: '2,000～3,999歩'),
  CommonRadioModel(code: '6', display: '2,000歩未満'),
];
List<CommonRadioModel> healthAndFitnetAnswers3 = [
  CommonRadioModel(code: '1', display: '週５日以上'),
  CommonRadioModel(code: '2', display: '週３～４日程度'),
  CommonRadioModel(code: '3', display: '週１～２日程度'),
  CommonRadioModel(code: '4', display: '月に１～２日程度'),
  CommonRadioModel(code: '5', display: 'していない'),
];

//REWARD question register reward
List<CommonRadioModel> rewardSurveyQuestion1 = [
  CommonRadioModel(code: '0', display: 'はい、毎日記録している'),
  CommonRadioModel(code: '1', display: '時々記録している'),
  CommonRadioModel(code: '2', display: '記録する習慣はない'),
];

List<CommonRadioModel> rewardSurveyQuestion2 = [
  CommonRadioModel(code: '0', display: 'はい、毎日目標を設定している'),
  CommonRadioModel(code: '1', display: 'たまに設定している'),
  CommonRadioModel(code: '2', display: '設定していない'),
];

List<CommonRadioModel> rewardSurveyQuestion3 = [
  CommonRadioModel(code: '0', display: 'エレベーターではなく階段を使う'),
  CommonRadioModel(code: '1', display: '移動手段を徒歩や自転車にする'),
  CommonRadioModel(code: '2', display: '特に工夫はしていない'),
];

List<CommonRadioModel> rewardSurveyQuestion4 = [
  CommonRadioModel(code: '0', display: '毎日運動している'),
  CommonRadioModel(code: '1', display: '週に3〜5回'),
  CommonRadioModel(code: '2', display: 'ほとんど運動しない'),
];

List<CommonRadioModel> rewardSurveyQuestion5 = [
  CommonRadioModel(code: '0', display: 'ポイントや報酬があると続けやすい'),
  CommonRadioModel(code: '1', display: '友達や家族と一緒に取り組むと続けやすい'),
  CommonRadioModel(code: '2', display: '自分の健康状態を記録すると続けやすい'),
];

List<CommonRadioModel> rewardSurveyQuestion6 = [
  CommonRadioModel(code: '0', display: '栄養バランスを考えて食べている'),
  CommonRadioModel(code: '1', display: 'カロリーを意識している'),
  CommonRadioModel(code: '2', display: '特に意識していない'),
];

List<CommonRadioModel> rewardSurveyQuestion7 = [
  CommonRadioModel(code: '0', display: '7時間以上'),
  CommonRadioModel(code: '1', display: '5〜6時間'),
  CommonRadioModel(code: '2', display: '5時間未満'),
];

List<CommonRadioModel> rewardSurveyQuestion8 = [
  CommonRadioModel(code: '0', display: 'すでに利用している'),
  CommonRadioModel(code: '1', display: '興味はあるがまだ使っていない'),
  CommonRadioModel(code: '2', display: 'あまり興味がない'),
];

List<CommonRadioModel> rewardSurveyQuestion9 = [
  CommonRadioModel(code: '0', display: '運動量を増やしたい'),
  CommonRadioModel(code: '1', display: '食生活を改善したい'),
  CommonRadioModel(code: '2', display: '睡眠習慣を見直したい'),
  CommonRadioModel(code: '3', display: '特に改善したいことはない'),
];

List<CommonRadioModel> rewardSurveyQuestion10 = [
  CommonRadioModel(code: '0', display: '改善することに関心がない'),
  CommonRadioModel(code: '1', display: '関心はあるが改善するつもりはない'),
  CommonRadioModel(code: '2', display: '改善するつもりである（概ね６ヶ月以内）'),
  CommonRadioModel(code: '3', display: '近いうちに（概ね１ヶ月以内）改善するつもりである'),
  CommonRadioModel(code: '4', display: '既に改善に取り組んでいる（６ヶ月未満）'),
  CommonRadioModel(code: '5', display: '運動習慣や食習慣に問題はないため改善する必要はない'),
];

List<CommonRadioModel> rewardSurveyQuestion11 = [
  CommonRadioModel(code: '0', display: '改善することに関心がない'),
  CommonRadioModel(code: '1', display: '関心はあるが改善するつもりはない'),
  CommonRadioModel(code: '2', display: '改善するつもりである（概ね６ヶ月以内）'),
  CommonRadioModel(code: '3', display: '近いうちに（概ね１ヶ月以内）改善するつもりである'),
  CommonRadioModel(code: '4', display: '既に改善に取り組んでいる（６ヶ月未満）'),
  CommonRadioModel(code: '5', display: '運動習慣や食習慣に問題はないため改善する必要はない'),
];

class CommonRadioQuestion {
  CommonRadioQuestion(
      {required this.question, required this.answers, required this.number});

  final String question;
  final int number;
  final List<CommonRadioModel> answers;
}

class CommonRadioModel extends RadioModel {
  final String code;
  final String display;
  final String? desciption;
  final bool isSelect;

  CommonRadioModel(
      {required this.code,
      required this.display,
      this.desciption,
      this.isSelect = false});

  @override
  String getItemDisplay() {
    return display;
  }

  @override
  String getItemId() {
    return code;
  }

  @override
  int? getCodeToInt() {
    int? codeParse = int.tryParse(code);
    return codeParse;
  }

  @override
  List<Object?> get props => [code];

  @override
  String? getItemDescription() {
    return desciption;
  }
}

abstract class ScrollModel {
  String getDisplayWithUnit(int value);

  int getMinValue();

  int getMaxValue();

  int initValue();

  String getDisplayNoUnit(int value);
}

final weightScrollModel =
    CommonScrollModel(minValue: 20, maxValue: 250, unit: "kg");
final heightScrollModel =
    CommonScrollModel(minValue: 50, maxValue: 250, unit: "cm");
final percentScrollModel =
    CommonScrollModel(minValue: 0, maxValue: 100, unit: "%");
final hourScrollModel =
    CommonScrollModel(minValue: 0, maxValue: 24, unit: "時間");
final minuteScrollModel =
    CommonScrollModel(minValue: 0, maxValue: 60, unit: "分");
final bodyIndexScrollModel =
    CommonScrollModel(minValue: 0, maxValue: 999, unit: '');
final bodyIndexCommonScrollModel =
    CommonScrollModel(minValue: 0, maxValue: 10, unit: '');
final bodyIndexHeightScrollModel =
    CommonScrollModel(minValue: 0, maxValue: 10, unit: 'cm');
final bodyIndexWeightScrollModel =
    CommonScrollModel(minValue: 0, maxValue: 10, unit: 'kg');
final yearScrollModel =
    CommonScrollModel(minValue: 1900, maxValue: DateTime.now().year, unit: '年');
final yearLimitScrollModel =
    CommonScrollModel(minValue: 1900, maxValue: DateTime.now().year, unit: '年');
final monthScrollModel =
    CommonScrollModel(minValue: 1, maxValue: 12, unit: '月');
final dayScrollModel = CommonScrollModel(minValue: 1, maxValue: 31, unit: '日');
// For height
final heightCommonScrollModel =
    CommonScrollModel(minValue: 50, maxValue: 250, unit: '');
// For weight
final weightCommonScrollModel =
    CommonScrollModel(minValue: 20, maxValue: 250, unit: '');
//For abdomen
final abdomenCommonScrollModel =
    CommonScrollModel(minValue: 30, maxValue: 200, unit: '');
//For abdomen
final bmiCommonScrollModel =
    CommonScrollModel(minValue: 10, maxValue: 60, unit: '');

// For heart rate
final heartRateScrollModel =
    CommonScrollModel(minValue: 30, maxValue: 220, unit: '拍/分');
// For _systolicBlood
final systolicBloodScrollModel =
    CommonScrollModel(minValue: 50, maxValue: 250, unit: 'mmHg');
// For _diastolicBlood
final diastolicBloodScrollModel =
    CommonScrollModel(minValue: 30, maxValue: 150, unit: 'mmHg');
// For _neutralFat
final neutralFatScrollModel =
    CommonScrollModel(minValue: 10, maxValue: 1000, unit: '');
// For _hdl
final hdlScrollModel = CommonScrollModel(minValue: 10, maxValue: 150, unit: '');
// For _ldl
final ldlScrollModel = CommonScrollModel(minValue: 30, maxValue: 250, unit: '');
// For fastingBloodSugar
final fastingBloodSugarScrollModel =
    CommonScrollModel(minValue: 50, maxValue: 300, unit: '');
// For hbA1cIndex
final hbA1cIndexScrollModel =
    CommonScrollModel(minValue: 3, maxValue: 15, unit: '');
final bodyFatPercentageScrollModel =
    CommonScrollModel(minValue: 3, maxValue: 60, unit: '%');

// For body temperature
final temperatureIntScrollModel =
    CommonScrollModel(minValue: 30, maxValue: 45, unit: '');
final temperatureDecimalScrollModel =
    CommonScrollModel(minValue: 0, maxValue: 10, unit: '°C');

// For body temperature
final sugarLevelIntScrollModel =
    CommonScrollModel(minValue: 0, maxValue: 200, unit: 'mg/dL');
final sugarLevelDecimalScrollModel =
    CommonScrollModel(minValue: 0, maxValue: 10, unit: 'mg/dL');

// For distance cycling
final cyclingDistanceIntScrollModel =
    CommonScrollModel(minValue: 0, maxValue: 500, unit: '');
final cyclingDistanceDecimalScrollModel =
    CommonScrollModel(minValue: 0, maxValue: 10, unit: 'km');

final kmScrollModel =
CommonScrollModel(minValue: 0, maxValue: 9999, unit: 'km');

class CommonScrollModel extends ScrollModel {
  int minValue;
  int maxValue;
  final String unit;

  CommonScrollModel(
      {required this.minValue, required this.maxValue, required this.unit});

  @override
  String getDisplayWithUnit(int value) {
    return "$value $unit";
  }

  @override
  int getMaxValue() {
    return maxValue;
  }

  @override
  int getMinValue() {
    return minValue;
  }

  @override
  int initValue() {
    return minValue;
  }

  @override
  String getDisplayNoUnit(int value) {
    return '$value';
  }

  @override
  String getUnit() {
    return unit;
  }

  void setMaxValue(int newValue) {
    maxValue = newValue;
  }
}

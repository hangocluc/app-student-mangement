import 'package:json_annotation/json_annotation.dart';

part 'demo_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class DemoModel {
  final String? name;
  final String? accessToken;
  final String? refreshToken;
  DemoModel({
    this.name,
    this.accessToken,
    this.refreshToken,
  });

  factory DemoModel.fromJson(Map<String, dynamic> json) {
    return _$DemoModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$DemoModelToJson(this);
}

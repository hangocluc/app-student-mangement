import 'package:json_annotation/json_annotation.dart';

part 'demo_request_model.g.dart';

@JsonSerializable(
    explicitToJson: true, includeIfNull: false, fieldRename: FieldRename.snake)
class DemoRequestModel {
  final String? name;
  final String? refreshToken;
  DemoRequestModel({this.name, this.refreshToken});

  factory DemoRequestModel.fromJson(Map<String, dynamic> json) {
    return _$DemoRequestModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$DemoRequestModelToJson(this);
}

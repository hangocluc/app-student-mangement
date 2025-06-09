import 'package:json_annotation/json_annotation.dart';

part 'login_response_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class LoginResponseModel {
  final String? username;
  final String? role;
  final String? refreshToken;
  LoginResponseModel({
    this.username,
    this.role,
    this.refreshToken,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return _$LoginResponseModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$LoginResponseModelToJson(this);
}

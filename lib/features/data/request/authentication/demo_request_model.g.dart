// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'demo_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DemoRequestModel _$DemoRequestModelFromJson(Map<String, dynamic> json) =>
    DemoRequestModel(
      name: json['name'] as String?,
      refreshToken: json['refresh_token'] as String?,
    );

Map<String, dynamic> _$DemoRequestModelToJson(DemoRequestModel instance) =>
    <String, dynamic>{
      if (instance.name case final value?) 'name': value,
      if (instance.refreshToken case final value?) 'refresh_token': value,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'demo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DemoModel _$DemoModelFromJson(Map<String, dynamic> json) => DemoModel(
      name: json['name'] as String?,
      accessToken: json['access_token'] as String?,
      refreshToken: json['refresh_token'] as String?,
    );

Map<String, dynamic> _$DemoModelToJson(DemoModel instance) => <String, dynamic>{
      'name': instance.name,
      'access_token': instance.accessToken,
      'refresh_token': instance.refreshToken,
    };

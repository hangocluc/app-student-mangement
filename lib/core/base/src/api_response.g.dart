// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiResponse<T> _$ApiResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    ApiResponse<T>(
      _$nullableGenericFromJson(json['data'], fromJsonT),
      (json['code'] as num?)?.toInt(),
      json['message'] as String?,
      json['success'] as bool?,
    )..errors = json['errors'];

Map<String, dynamic> _$ApiResponseToJson<T>(
  ApiResponse<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'data': _$nullableGenericToJson(instance.data, toJsonT),
      'code': instance.code,
      'success': instance.success,
      'message': instance.message,
      'errors': instance.errors,
    };

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) =>
    input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) =>
    input == null ? null : toJson(input);

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      code: json['code'] as String?,
      message: json['message'] as String?,
      args: json['args'],
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'args': instance.args,
    };

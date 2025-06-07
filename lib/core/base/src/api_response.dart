import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';

part 'api_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class ApiResponse<T> {
  final T? data;
  int? code;
  bool? success;
  String? message;
  dynamic errors;

  bool get isSuccessResponse {
    return code != null && code == 200;
  }

  ApiResponse(this.data, this.code, this.message, this.success);

  factory ApiResponse.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$ApiResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$ApiResponseToJson(this, toJsonT);

  static String? getMessageFromException(dynamic exception) {
    if (exception is DioException) {
      try {
        final messageResult = ApiResponse.fromJson(
          exception.response?.data,
          (json) {},
        ).message;

        if ((messageResult?.isEmpty ?? true) && exception.message != null) {
          return exception.message;
        }
        return messageResult;
      } catch (e) {
        return exception.message;
      }
    } else {
      return exception.toString().replaceAll("Exception:", "");
    }
  }

  static Map<String, String>? getErrors(dynamic exception) {
    if (exception is DioException) {
      try {
        final res = ApiResponse.fromJson(
          exception.response?.data,
          (json) {},
        );
        if (res.errors is Map<String, String>?) {
          return res.errors;
        } else if (res.errors is Map) {
          Map<String, String> errorResult = {};
          res.errors.forEach((key, value) {
            errorResult[key] = value.toString();
          });
          return errorResult;
        }
      } catch (e) {
        return null;
      }
    }
    return null;
  }
}

@JsonSerializable()
class Message {
  final String? code;
  final String? message;
  final dynamic args;

  const Message({
    this.code,
    this.message,
    this.args,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return _$MessageFromJson(json);
  }

  Map<String, dynamic> toJson() => _$MessageToJson(this);
}

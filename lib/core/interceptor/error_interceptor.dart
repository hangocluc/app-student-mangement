import 'dart:convert';
import 'dart:developer';
// ignore: depend_on_referenced_packages
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../common/configure/exception/api_exception.dart';
import '../../common/utils/common_utils.dart';
import '../../common/widget/app_loading_overlay/app_loading_overlay.dart';
import '../../features/app/app_env/env.dart';
import '../../features/data/models/models.dart';
import '../../features/data/request/authentication/demo_request_model.dart';
import '../../main.dart';
import '../base/src/api_response.dart';
import '../navigator/navigator_service.dart';
import 'api_header.dart';
import 'unauth_interceptor.dart';

class HandleErrorInterceptor extends Interceptor {
  HandleErrorInterceptor(
      {this.errorTokenExpired, this.errorNoInternet, this.apiHeader});

  final VoidCallback? errorTokenExpired;
  final VoidCallback? errorNoInternet;
  final ApiHeader? apiHeader;
  bool shouldLogout = false;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    options.responseType = ResponseType.json;
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final apiException = await err.toApiException();

    DioException error = err.copyWith(
      error: apiException,
      message: apiException.message,
    );
    shouldLogout = error.response?.data?['should_logout'] ?? false;
    log("Dio Error: ${error.response?.statusCode} ${error.toString()}");
    log("Error response: ${error.response}");
    log("DioException: ${err.toString()}");

    if (err.type == DioExceptionType.connectionError) {
      errorNoInternet?.call();
    }

    if (apiException.statusCode == 401) {
      _handleLogout(err, handler, apiHeader, shouldLogout);
    }
    if (apiException.statusCode != 401) {
      return handler.next(error);
    }
  }
}

extension on DioException {
  Future<ApiException> toApiException() async {
    final errorCode = response?.statusCode ?? 0;
    final path = response?.requestOptions.uri.path ?? '';

    if (errorCode == 503) {
      return ApiException.internalServerError(
          path, 'Internal Server Error', '$errorCode', errorCode);
    }

    String? code;
    String? message;
    // dynamic args;

    try {
      final messages = ((response?.data?['messages'] ?? []) as List<dynamic>?)
              ?.map((e) => Message.fromJson(e))
              .toList() ??
          [];

      code = messages.firstOrNull?.code;
      message = messages.firstOrNull?.message;
      // args = messages.firstOrNull?.args;
    } catch (error) {
      try {
        // Handle error case for OCR
        if (response?.data?['error'] is String) {
          code = response?.data?['statusCode'].toString();
          message = response?.data?['error'].toString();
        }
      } catch (_) {
        rethrow;
      }

      debugPrint('error= $error');
    }

    switch (errorCode) {
      case 400:
        return ApiException.badRequest(
            path, message ?? '接続が中断されました。時間をおいて再試行してください。', code, errorCode);
      case 422:
        return ApiException.badRequest(
            path, message ?? '接続が中断されました。時間をおいて再試行してください。', code, errorCode);
      case 401:
        return ApiException.unauthorized(
            path, message ?? '接続が中断されました。時間をおいて再試行してください。', code, errorCode);
      case 403:
        return ApiException.forbidden(
            path, message ?? '接続が中断されました。時間をおいて再試行してください。', code, errorCode);
      case 404:
        return ApiException.notFound(
            path, message ?? '接続が中断されました。時間をおいて再試行してください。', code, errorCode);
      case 500:
        return ApiException.internalServerError(
            path, message ?? '接続が中断されました。時間をおいて再試行してください。', code, errorCode);
      default:
        return ApiException.noConnection(
            path, 'language.lblCommonErrorInternetConnect', "1000", 0);
    }
  }
}

Future refreshToken(DioException err, ErrorInterceptorHandler handler,
    BuildContext context, ApiHeader? apiHeader) async {
  final apiException = await err.toApiException();
  DioException error = err.copyWith(error: apiException);
  if (err.requestOptions.headers.containsKey('Authorization')) {
    Dio dio = _initDio();

    final refreshToken = apiHeader?.getRefreshToken();

    final requestRefreshToken = DemoRequestModel(refreshToken: refreshToken);
    try {
      final response = await dio.post(
        'AuthApiPath.refreshToken',
        data: jsonEncode(requestRefreshToken),
      );
      if (response.statusCode == 200) {
        final result = ApiResponse<DemoModel>.fromJson(
          response.data!,
          (json) => DemoModel.fromJson(json as Map<String, dynamic>),
        );

        _saveTokenInfo(result, apiHeader);

        err.requestOptions.headers['Authorization'] =
            'Bearer ${result.data?.accessToken}';

        return handler.resolve(await dio.fetch(err.requestOptions));
      } else {
        apiHeader?.clearToken();
        if (context.mounted) {
          showSessionExpiredDialog(context);
        }
      }
    } catch (e) {
      log(e.toString());
    }
  } else {
    handler.next(error);
  }
}

Dio _initDio() {
  final env = sl.get<Env>().envNetwork;
  final isProduction = sl.get<Env>().isProduction;
  final dioOption = BaseOptions(
    baseUrl: env.apiServer,
    connectTimeout: Duration(seconds: env.apiConnectTimeout),
    receiveTimeout: Duration(seconds: env.apiReceiverTimeout),
    sendTimeout: Duration(seconds: env.apiSendTimeout),
    contentType: env.apiContentType,
  );
  final dio = Dio(dioOption);
  dio.interceptors.addAll([
    HandleErrorInterceptor(apiHeader: sl.get()),
    UnauthInterceptor(),
  ]);
  if (!isProduction && alice != null) {
    dio.interceptors.add(alice!.getDioInterceptor());
  }
  return dio;
}

void _saveTokenInfo(ApiResponse<DemoModel> result, ApiHeader? apiHeader) {
  apiHeader?.setAccessToken(result.data?.accessToken ?? '');
  apiHeader?.setRefreshToken(result.data?.refreshToken ?? '');
}

void _refreshToken(
    DioException err, ErrorInterceptorHandler handler, ApiHeader? apiHeader) {
  final context = sl.get<NavigationService>().navigatorKey.currentContext;

  if (context != null) {
    refreshToken(err, handler, context, apiHeader);
  }
}

void _handleLogout(DioException err, ErrorInterceptorHandler handler,
    ApiHeader? apiHeader, bool shouldLogout) {
  final context = sl.get<NavigationService>().navigatorKey.currentContext;
  //GenerateRoute.currentContext;
  if (shouldLogout == true && context != null) {
    apiHeader?.clearToken();
    dismissLoadingOverlay(context);
  } else {
    _refreshToken(err, handler, apiHeader);
  }
}

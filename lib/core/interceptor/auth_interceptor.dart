import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'api_header.dart';
import 'curl_interceptor.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final apiHeader = GetIt.instance.get<ApiHeader>();
    if (apiHeader.getAccessToken() != null) {
      options.headers = apiHeader.getAccessTokenHeader()
        ..addAll(ApiHeader.defaultHeader);
    }
    try {
      log('COPY CURL and send it to BE');
      log(cURLRepresentation(options));
    } catch (e) {
      log('Create CURL failure!! - $e');
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log("Response of API: ${response.realUri.host}${response.realUri.path}\ndata: ${jsonEncode(response.data)}",
        time: DateTime.now());
    super.onResponse(response, handler);
  }
}

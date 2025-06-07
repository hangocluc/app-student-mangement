// ignore: depend_on_referenced_packages

import 'package:dio/dio.dart';
// ignore: depend_on_referenced_packages
import 'package:retrofit/retrofit.dart';

import '../../../../../core/base/base.dart';
import '../../../models/auth/login_response_model.dart';
import '../../../request/auth/login_request_model.dart';
import 'api_path.dart';

part 'auth_service.g.dart';

@RestApi()
abstract class AuthService {
  factory AuthService(Dio dio, {String baseUrl}) = _AuthService;

  @GET(DemoApiPath.demo)
  Future<ApiResponse<LoginResponseModel>> login(
      @Body() LoginRequestModel request);
}

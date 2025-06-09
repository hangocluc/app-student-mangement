import 'dart:developer';

import 'package:base_bloc_cubit/core/base/src/api_response.dart';
import 'package:base_bloc_cubit/features/data/models/auth/login_response_model.dart';
import 'package:base_bloc_cubit/features/data/providers/network_service/src/auth_service.dart';
import 'package:base_bloc_cubit/features/domain/repositories/src/authentication/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  final AuthService _authService;

  LoginRepositoryImpl({required AuthService authService})
      : _authService = authService;

  @override
  Future<ApiResponse<LoginResponseModel?>> login(
      {required String username, required String password}) async {
    try {
      final response = await _authService.login(username, password);
      return response;
    } catch (error) {
      log('Error in getStudents: $error');
      rethrow;
    }
  }
}

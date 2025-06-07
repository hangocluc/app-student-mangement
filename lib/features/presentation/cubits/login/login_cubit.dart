import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../../core/interceptor/api_header.dart';
import '../../../domain/usecases/src/auth/login_usecase.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final _loginUsecase = GetIt.instance<LoginUsecase>();
  final _apiHeader = GetIt.instance<ApiHeader>();

  LoginCubit() : super(const LoginStateInitial());

  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      emit(const LoginStateLoading());

      final result = await _loginUsecase(
        LoginParams(
          email: email,
          password: password,
        ),
      );

      result.fold(
        (error) => emit(LoginStateError(error.toString())),
        (response) async {
          if (response?.accessToken != null) {
            await _apiHeader.setAccessToken(response!.accessToken!);
            if (response.refreshToken != null) {
              await _apiHeader.setRefreshToken(response.refreshToken!);
            }
            emit(const LoginStateSuccess());
          } else {
            emit(const LoginStateError('Login failed'));
          }
        },
      );
    } catch (e) {
      emit(LoginStateError(e.toString()));
    }
  }
}

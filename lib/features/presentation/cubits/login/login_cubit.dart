import 'package:base_bloc_cubit/core/base/src/api_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/extension/src/string_extension.dart';

import '../../../domain/usecases/src/auth/login_usecase.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUsecase usecase;
  //final _apiHeader = GetIt.instance<ApiHeader>();

  LoginCubit({required this.usecase}) : super(const LoginStateInitial());

  Future<void> login({
    required String username,
    required String password,
  }) async {
    try {
      emit(const LoginStateLoading());

      final result = await usecase
          .call(LoginParams(username: username, password: password));

      result.fold(
        (l) {
          if (l is DioException) {
            final String? message = ApiResponse.getMessageFromException(l);
            emit(LoginStateError(message ?? ''));
          } else {
            emit(LoginStateError(messageFromException(l)));
          }
        },
        (r) {
          emit(const LoginStateSuccess());
        },
      );
    } catch (e) {
      emit(LoginStateError(e.toString()));
    }
  }
}

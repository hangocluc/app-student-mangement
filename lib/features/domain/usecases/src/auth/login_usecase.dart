import 'package:base_bloc_cubit/core/base/src/base_usecase.dart';
import 'package:base_bloc_cubit/features/data/models/auth/login_response_model.dart';
import 'package:base_bloc_cubit/features/domain/repositories/src/authentication/login_repository.dart';
import 'package:dartz/dartz.dart';

class LoginParams {
  final String email;
  final String password;

  LoginParams({
    required this.email,
    required this.password,
  });
}

class LoginUsecase extends BaseUseCase<LoginResponseModel?, LoginParams> {
  final LoginRepository repository;

  LoginUsecase({required this.repository});

  @override
  Future<Either<Exception, LoginResponseModel?>> call(
      LoginParams params) async {
    try {
      final response = await repository.login(
        email: params.email,
        password: params.password,
      );
      return Right(response?.data);
    } on Exception catch (error) {
      return Left(error);
    }
  }
}

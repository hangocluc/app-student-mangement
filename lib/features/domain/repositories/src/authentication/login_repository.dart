import '../../../../../core/base/src/api_response.dart';
import '../../../../data/models/auth/login_response_model.dart';

abstract class LoginRepository {
  Future<ApiResponse<LoginResponseModel?>> login({
    required String username,
    required String password,
  });
}

import 'package:get_it/get_it.dart';

import '../../data/repositories/src/auth/login_repository_impl.dart';
import '../../data/repositories/src/demo/demo_repository_impl.dart';
import '../../domain/repositories/src/authentication/demo_repository.dart';
import '../../domain/repositories/src/authentication/login_repository.dart';

Future<void> registerRepositoryDI(GetIt sl) async {
  sl.registerFactory<DemoRepository>(
    () => DemoRepositoryImpl(demoService: sl.get()),
  );

  sl.registerFactory<LoginRepository>(
    () => LoginRepositoryImpl(authService: sl.get()),
  );
}

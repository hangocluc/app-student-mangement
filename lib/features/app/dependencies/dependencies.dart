import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../../common/common_di.dart';
import '../../../core/navigator/navigator_service.dart';
import 'cubit_dependencies.dart';
import 'network_dependencies.dart';
import 'repository_dependencies.dart';
import 'usecase_dependencies.dart';
import '../../data/providers/network_service/src/auth_service.dart';
import '../../data/providers/network_service/src/demo_service.dart';

Future<void> registerDependencies(GetIt sl) async {
  await commonDI(sl);

  await registerNetworkDependencies(sl);
  await registerRepositoryDI(sl);
  await registerUseCaseDI(sl);
  await registerCubitDI(sl);

  // Register services
  sl.registerFactory<AuthService>(
    () => AuthService(
      sl.get<Dio>(instanceName: INSTANCE_UNAUTH_DIO),
    ),
  );
}

Future<void> registerNavigator(GetIt sl) async {
  sl.registerLazySingleton(() => NavigationService());
}

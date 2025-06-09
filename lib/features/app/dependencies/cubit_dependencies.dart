import 'package:base_bloc_cubit/features/presentation/cubits/demo_cubit/demo_cubit.dart';
import 'package:base_bloc_cubit/features/presentation/cubits/login/login_cubit.dart';
import 'package:base_bloc_cubit/features/presentation/cubits/student/student_cubit.dart';
import 'package:get_it/get_it.dart';

Future<void> registerCubitDI(GetIt sl) async {
  sl.registerLazySingleton(
    () => DemoCubit(usecase: sl.get(), sharedPreferences: sl.get()),
  );
  sl.registerLazySingleton(
    () => StudentCubit(usecase: sl.get()),
  );
  sl.registerLazySingleton(
    () => LoginCubit(usecase: sl.get()),
  );
}

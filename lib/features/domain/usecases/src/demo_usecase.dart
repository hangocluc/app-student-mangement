import 'package:base_bloc_cubit/features/data/models/class.dart';
import 'package:base_bloc_cubit/features/data/models/student/student_model.dart';

import '../../../../core/base/src/base_usecase.dart';
import '../../entities/src/demo_entity.dart';
import '../../repositories/src/authentication/demo_repository.dart';
import 'package:dartz/dartz.dart';

class DemoUsecase extends BaseUseCase<DemoEntity?, NoParams?> {
  final DemoRepository repository;

  DemoUsecase({required this.repository});

  @override
  Future<Either<Exception, DemoEntity?>> call(params) async {
    try {
      final response = await repository.getDemo();
      return Right(response?.data);
    } on Exception catch (error) {
      return Left(error);
    }
  }

  Future<Either<Exception, List<StudentEntity>?>> getStudents() async {
    try {
      final response = await repository.getStudents();
      return Right(response);
    } on Exception catch (error) {
      return Left(error);
    }
  }

  Future<Either<Exception, bool?>> deleteStudent(params) async {
    try {
      final response = await repository.deleteStudent(maSV: params);
      return Right(response);
    } on Exception catch (error) {
      return Left(error);
    }
  }

  Future<Either<Exception, List<Class>?>> getClass() async {
    try {
      final response = await repository.getClasses();
      return Right(response);
    } on Exception catch (error) {
      return Left(error);
    }
  }

  Future<Either<Exception, bool?>> createStudents(StudentModel student) async {
    try {
      final response = await repository.createStudent(student: student);
      return Right(response);
    } on Exception catch (error) {
      return Left(error);
    }
  }
}

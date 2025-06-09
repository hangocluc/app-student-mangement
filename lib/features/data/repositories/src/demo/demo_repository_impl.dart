import 'dart:developer';

import 'package:base_bloc_cubit/core/base/src/api_response.dart';
import 'package:base_bloc_cubit/features/data/models/class.dart';
import 'package:base_bloc_cubit/features/data/models/student/student_model.dart';

import '../../../../domain/repositories/src/authentication/demo_repository.dart';
import '../../../models/models.dart';
import '../../../providers/network_service/src/demo_service.dart';

class DemoRepositoryImpl implements DemoRepository {
  final DemoService demoService;

  DemoRepositoryImpl({required this.demoService});

  @override
  Future<ApiResponse<DemoModel>?> getDemo({String? username}) async {
    try {
      final response = await demoService.demo();
      if (response.isSuccessResponse) {
        return response;
      }
      throw Exception(response.message);
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<List<StudentModel>?> getStudents({String? maSV}) async {
    try {
      final response = await demoService.getStudents(maSV);
      if (response.isSuccessResponse) {
        return response.data;
      }
      throw Exception(response.message);
    } catch (error) {
      log('Error in getStudents: $error');

      rethrow;
    }
  }

  @override
  Future<bool?> deleteStudent({required String maSV}) async {
    try {
      final response = await demoService.deleteStudent(maSV);
      if (response.isSuccessResponse) {
        return true;
      }
      throw Exception(response.message);
    } catch (error) {
      log('Error in getStudents: $error');

      rethrow;
    }
  }

  @override
  Future<bool?> createStudent({required StudentModel student}) async {
    try {
      final response = await demoService.createStudent(
        student.name ?? '',
        student.dateOfBirth ?? '',
        student.gender ?? '',
        student.classCode ?? '',
      );
      if (response.isSuccessResponse) {
        return true;
      }
      throw Exception(response.message);
    } catch (error) {
      log('Error in getStudents: $error');

      rethrow;
    }
  }

  @override
  Future<bool?> updateStudents({required StudentModel student}) async {
    try {
      final response = await demoService.updateStudents(
          student.name ?? '',
          student.dateOfBirth ?? '',
          student.gender ?? '',
          student.classCode ?? '',
          student.studentId ?? '');
      if (response.isSuccessResponse) {
        return true;
      }
      throw Exception(response.message);
    } catch (error) {
      log('Error in getStudents: $error');
      rethrow;
    }
  }

  @override
  Future<List<Class>?> getClasses() async {
    try {
      final response = await demoService.getClasses();
      return response.data;
    } catch (error) {
      log('Error in getStudents: $error');
      rethrow;
    }
  }
}

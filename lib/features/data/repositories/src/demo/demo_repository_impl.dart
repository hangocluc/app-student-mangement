import 'dart:developer';

import 'package:base_bloc_cubit/core/base/src/api_response.dart';
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
  Future<List<StudentModel>?> getStudents() async {
    try {
      final response = await demoService.getStudents();
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
}

import 'package:base_bloc_cubit/features/data/models/class.dart';

import '../../../../../core/base/src/api_response.dart';
import '../../../../data/models/student/student_model.dart';

abstract class DemoRepository {
  Future<ApiResponse?> getDemo({
    String? username,
  });

  Future<List<StudentModel>?> getStudents({String? maSV});

  Future<bool?> deleteStudent({required String maSV});

  Future<bool?> createStudent({required StudentModel student});

  Future<bool?> updateStudents({required StudentModel student});

  Future<List<Class>?> getClasses();
}

import '../../../../../core/base/src/api_response.dart';
import '../../../../data/models/student/student_model.dart';

abstract class DemoRepository {
  Future<ApiResponse?> getDemo({
    String? username,
  });
  Future<List<StudentModel>?> getStudents();
  Future<bool?> deleteStudent({required String maSV});
}

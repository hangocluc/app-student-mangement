import 'package:base_bloc_cubit/common/widget/app_toast/app_toast.dart';
import 'package:base_bloc_cubit/features/data/models/class.dart';
import 'package:base_bloc_cubit/features/data/models/student/student_model.dart';
import 'package:base_bloc_cubit/features/domain/usecases/src/demo_usecase.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

class AddStudentController extends GetxController {
  DemoUsecase usecase = GetIt.instance.get<DemoUsecase>();

  final classes = RxList<Class>([]);
  final student = StudentModel();

  @override
  void onInit() {
    super.onInit();
    getClasses();
  }

  Future<void> getClasses() async {
    final result = await usecase.getClass();
    result.fold((_) {
      showError();
    }, (data) {
      classes.value = data ?? [];
    });
  }

  Future<void> createStudent() async {
    EasyLoading.show();
    final result = await usecase.createStudents(student);
    EasyLoading.dismiss();
    result.fold((a) {
      showError();
    }, (data) {
      if (data == true) {
        Get.back(result: true);
        showToastSuccess(Get.context!, 'Thêm thành công');
      } else {
        showError();
      }
    });
  }

  void showError() {
    showToastError(Get.context!, 'Có lỗi xảy ra, vui lòng thử lại sau');
  }

  bool enoughField() {
    return student.name?.isNotEmpty == true &&
        student.gender?.isNotEmpty == true &&
        student.className?.isNotEmpty == true &&
        student.dateOfBirth?.isNotEmpty == true;
  }
}

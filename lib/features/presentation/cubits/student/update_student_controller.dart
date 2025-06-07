import 'package:base_bloc_cubit/common/widget/app_toast/app_toast.dart';
import 'package:base_bloc_cubit/features/data/models/class.dart';
import 'package:base_bloc_cubit/features/data/models/student/student_model.dart';
import 'package:base_bloc_cubit/features/domain/usecases/src/demo_usecase.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

class UpdateStudentController extends GetxController {
  DemoUsecase usecase = GetIt.instance.get<DemoUsecase>();

  final classes = RxList<Class>([]);
  StudentModel student = StudentModel();

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

  Future<void> updateStudents() async {
    try {
      EasyLoading.show();
      final result = await usecase.updateStudents(student);
      EasyLoading.dismiss();
      result.fold((a) {
        showError();
      }, (data) {
        if (data == true) {
          Get.back(result: true);
          showToastSuccess(Get.context!, 'Update successfully');
        } else {
          showError();
        }
      });
    } catch (_) {
      EasyLoading.dismiss();
      showError();
    }
  }

  void showError() {
    showToastError(Get.context!, 'Có lỗi xảy ra, vui lòng thử lại sau');
  }

  bool enoughField() {
    return student.name?.isNotEmpty == true &&
        student.gender?.isNotEmpty == true &&
        student.classCode?.isNotEmpty == true &&
        student.dateOfBirth?.isNotEmpty == true;
  }
}

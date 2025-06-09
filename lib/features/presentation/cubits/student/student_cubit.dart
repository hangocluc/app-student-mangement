import 'package:base_bloc_cubit/common/widget/app_toast/app_toast.dart';
import 'package:base_bloc_cubit/features/domain/usecases/src/demo_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../../data/models/student/student_model.dart';
import 'student_state.dart';

class StudentCubit extends Cubit<StudentState> {
  DemoUsecase usecase;
  List<StudentModel> _students = [];

  StudentCubit({required this.usecase}) : super(const StudentStateInitial()) {
    _students = List.from([]);
  }

  Future<void> loadStudents() async {
    try {
      emit(const StudentStateLoading());
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 500));
      // emit(StudentStateSuccess(_students));
    } catch (e) {
      emit(StudentStateError(e.toString()));
    }
  }

  Future<void> createStudent(StudentModel student) async {
    try {
      emit(const StudentStateLoading());
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 500));
      _students.add(student);
      // emit(StudentStateSuccess(_students));
    } catch (e) {
      emit(StudentStateError(e.toString()));
    }
  }

  Future<void> deleteStudent(String maSV) async {
    try {
      EasyLoading.show();
      final data = await usecase.deleteStudent(maSV);
      EasyLoading.dismiss();
      data.fold(
        (l) {
          showToastError(
              Get.context!, 'Something went wrong, please try again');
        },
        (r) {
          showToastSuccess(Get.context!, 'Delete student successfully');
          getStudents();
        },
      );
    } catch (e) {
      EasyLoading.dismiss();
      showToastError(Get.context!, 'Something went wrong, please try again');
      emit(StudentStateError(e.toString()));
    }
  }

  Future<void> getStudents({String? maSV}) async {
    try {
      emit(const StudentStateLoading());

      final data = await usecase.getStudents(maSV);
      data.fold(
        (l) {
          emit(StudentStateError(l.toString()));
        },
        (r) {
          emit(StudentStateSuccess(r ?? []));
        },
      );
    } catch (e) {
      emit(StudentStateError(e.toString()));
    }
  }
}

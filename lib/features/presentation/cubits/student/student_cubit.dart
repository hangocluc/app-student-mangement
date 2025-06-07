import 'package:base_bloc_cubit/features/domain/usecases/src/demo_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/student/student_model.dart';
import '../../model/student_model_ui.dart';
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

  Future<void> getStudent(String id) async {
    try {
      emit(const StudentStateLoading());
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 500));
      final student = _students.firstWhere(
        (student) => student.id == id,
        orElse: () => throw Exception('Student not found'),
      );
      //  emit(StudentStateSuccess([student]));
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

  Future<void> updateStudent(StudentModel student) async {
    try {
      emit(const StudentStateLoading());
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 500));
      final index = _students.indexWhere((s) => s.id == student.id);
      if (index != -1) {
        _students[index] = student;
        // emit(StudentStateSuccess(_students));
      } else {
        throw Exception('Student not found');
      }
    } catch (e) {
      emit(StudentStateError(e.toString()));
    }
  }

  Future<void> deleteStudent(String maSV) async {
    try {
      emit(const StudentStateLoading());
      // Simulate network delay
      final data = await usecase.deleteStudent(maSV);
      data.fold(
        (l) {
          emit(StudentStateError(l.toString()));
        },
        (r) {
          emit(DeleteStudentStateSuccess(data: r ?? true));
        },
      );

      //  emit(StudentStateSuccess(_students));
    } catch (e) {
      emit(StudentStateError(e.toString()));
    }
  }

  Future<void> getStudents() async {
    try {
      emit(const StudentStateLoading());
      // Simulate network delay
      final data = await usecase.getStudents();
      data.fold(
        (l) {
          emit(StudentStateError(l.toString()));
        },
        (r) {
          emit(StudentStateSuccess(r
                  ?.map((e) => StudentModelUI(
                      studentId: e.studentId ?? '',
                      name: e.name ?? '',
                      id: e.id ?? '',
                      className: e.className ?? ''))
                  .toList() ??
              []));
        },
      );
    } catch (e) {
      emit(StudentStateError(e.toString()));
    }
  }
}

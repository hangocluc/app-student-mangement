import 'package:equatable/equatable.dart';
import '../../../data/models/student/student_model.dart';

abstract class StudentState extends Equatable {
  const StudentState();

  @override
  List<Object?> get props => [];
}

class StudentStateInitial extends StudentState {
  const StudentStateInitial();
}

class StudentStateLoading extends StudentState {
  const StudentStateLoading();
}

class StudentStateSuccess extends StudentState {
  final List<StudentModel> students;

  const StudentStateSuccess(this.students);

  @override
  List<Object?> get props => [students];
}

class DeleteStudentStateSuccess extends StudentState {
  final bool data;

  const DeleteStudentStateSuccess({this.data = false});
}

class StudentStateError extends StudentState {
  final String message;

  const StudentStateError(this.message);

  @override
  List<Object?> get props => [message];
}

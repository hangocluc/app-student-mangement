import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => [];
}

class LoginStateInitial extends LoginState {
  const LoginStateInitial();
}

class LoginStateLoading extends LoginState {
  const LoginStateLoading();
}

class LoginStateSuccess extends LoginState {
  const LoginStateSuccess();
}

class LoginStateError extends LoginState {
  final String message;

  const LoginStateError(this.message);

  @override
  List<Object?> get props => [message];
}

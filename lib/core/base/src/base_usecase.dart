import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

abstract class BaseUseCase<Type, Params> {
  Future<Either<Exception, Type>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}

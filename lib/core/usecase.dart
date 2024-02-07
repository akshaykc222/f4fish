import 'package:equatable/equatable.dart';

abstract class UseCase<Type, Params> {
  Future<Type> call(Params params);
}

abstract class NoFutureUseCase<Type, Params> {
  Type call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}

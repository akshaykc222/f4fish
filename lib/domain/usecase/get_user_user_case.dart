import 'package:grocery_app/core/usecase.dart';
import 'package:grocery_app/domain/entity/user_entity.dart';
import 'package:grocery_app/domain/repository/auth_data_repository.dart';

class GetUserUseCaseAddress extends UseCase<UserEntity, NoParams> {
  final AuthDataRepository repository;

  GetUserUseCaseAddress(this.repository);

  @override
  Future<UserEntity> call(NoParams params) {
    return repository.getUser();
  }
}

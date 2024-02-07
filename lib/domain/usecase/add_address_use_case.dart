import 'package:grocery_app/core/usecase.dart';
import 'package:grocery_app/domain/entity/user_entity.dart';
import 'package:grocery_app/domain/repository/auth_data_repository.dart';

class AddAddressUseCase extends UseCase<NoParams, UserEntity> {
  final AuthDataRepository repository;

  AddAddressUseCase(this.repository);

  @override
  Future<NoParams> call(UserEntity params) {
    repository.addAddress(params);
    return Future.value(NoParams());
  }
}

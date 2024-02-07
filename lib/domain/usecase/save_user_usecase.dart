import 'package:grocery_app/domain/repository/auth_local_repositary.dart';

import '../../core/usecase.dart';

class SaveUserUseCase extends UseCase<void, Map<String, dynamic>> {
  final AuthLocalRepository repository;

  SaveUserUseCase(this.repository);

  @override
  Future<void> call(Map<String, dynamic> params) {
    return repository.saveUser(params);
  }
}

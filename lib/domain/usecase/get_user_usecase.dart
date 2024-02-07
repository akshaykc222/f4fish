import 'package:grocery_app/domain/repository/auth_local_repositary.dart';

import '../../core/usecase.dart';

class GetUserUseCase extends UseCase<Map<String, dynamic>, NoParams> {
  final AuthLocalRepository repository;

  GetUserUseCase(this.repository);

  @override
  Future<Map<String, dynamic>> call(NoParams params) {
    return repository.getUser();
  }
}

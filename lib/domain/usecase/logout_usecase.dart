import 'package:grocery_app/domain/repository/auth_local_repositary.dart';

import '../../core/usecase.dart';

class LogoutUseCase extends UseCase<void, NoParams> {
  final AuthLocalRepository repository;

  LogoutUseCase(this.repository);

  @override
  Future<void> call(NoParams params) async {
    repository.logout();
  }
}

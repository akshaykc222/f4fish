import 'package:grocery_app/domain/repository/auth_local_repositary.dart';

import '../../core/usecase.dart';

class GetTokenUserCase extends UseCase<String, NoParams> {
  final AuthLocalRepository repository;

  GetTokenUserCase(this.repository);
  @override
  Future<String> call(NoParams params) {
    return repository.getToken();
  }
}

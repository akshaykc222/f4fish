import 'package:grocery_app/domain/repository/auth_local_repositary.dart';

import '../../core/usecase.dart';

class SaveTokenUserCase extends UseCase<void, String> {
  final AuthLocalRepository repository;

  SaveTokenUserCase(this.repository);
  @override
  Future<void> call(String params) async {
    repository.saveToken(params);
  }
}

import 'package:grocery_app/core/usecase.dart';
import 'package:grocery_app/domain/repository/auth_data_repository.dart';

class AuthRegisterOtpUseCase
    extends UseCase<Map<String, dynamic>, Map<String, dynamic>> {
  final AuthDataRepository repository;

  AuthRegisterOtpUseCase(this.repository);

  @override
  Future<Map<String, dynamic>> call(Map<String, dynamic> params) {
    return repository.getToken(params['mobile'], params['token']);
  }
}

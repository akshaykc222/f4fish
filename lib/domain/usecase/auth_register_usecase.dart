import 'package:grocery_app/core/usecase.dart';
import 'package:grocery_app/domain/repository/auth_data_repository.dart';

class AuthRegisterUseCase extends UseCase<LoginResponseModel, LoginModel> {
  final AuthDataRepository repository;

  AuthRegisterUseCase(this.repository);

  @override
  Future<LoginResponseModel> call(LoginModel params) {
    return repository.registerPhone(params.mobile,);
  }
}

class LoginModel {
  final String mobile;
  final String password;

  LoginModel(this.mobile, this.password);
}

class LoginResponseModel {
  final bool? isStaff;
  final String token;

  LoginResponseModel(this.isStaff, this.token);
  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginResponseModel(json["is_staff"], json["token"]);
}

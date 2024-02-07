import 'package:grocery_app/data/remote/data_source/auth_data_source.dart';
import 'package:grocery_app/domain/entity/user_entity.dart';
import 'package:grocery_app/domain/repository/auth_data_repository.dart';
import 'package:grocery_app/domain/usecase/auth_register_usecase.dart';

class AuthDataRepositoryImpl extends AuthDataRepository {
  final AuthDataSource dataSource;

  AuthDataRepositoryImpl(this.dataSource);

  @override
  Future<Map<String, dynamic>> getToken(String phone, String otp) {
    return dataSource.getToken(phone, otp);
  }

  @override
  Future<LoginResponseModel> registerPhone(String phone,) {
    return dataSource.registerPhone(phone, );
  }

  @override
  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<void> addAddress(UserEntity data) {
    return dataSource.addAddress(data);
  }

  @override
  Future<UserEntity> getUser() {
    return dataSource.getUser();
  }
}

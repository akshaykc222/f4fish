import '../entity/user_entity.dart';
import '../usecase/auth_register_usecase.dart';

abstract class AuthDataRepository {
  Future<Map<String, dynamic>> getToken(String phone, String otp);
  Future<LoginResponseModel> registerPhone(String phone);
  Future<UserEntity> getUser();
  Future<void> addAddress(UserEntity data);
}

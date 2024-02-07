import 'package:grocery_app/core/api_provider.dart';
import 'package:grocery_app/data/remote/routes.dart';

import '../../../domain/entity/user_entity.dart';
import '../../../domain/usecase/auth_register_usecase.dart';

abstract class AuthDataSource {
  Future<Map<String, dynamic>> getToken(String phone, String otp);
  Future<LoginResponseModel> registerPhone(String phone,);
  Future<UserEntity> getUser();
  Future<void> addAddress(UserEntity data);
}

class AuthDataSourceImpl implements AuthDataSource {
  final ApiProvider apiProvider;

  AuthDataSourceImpl(this.apiProvider);

  @override
  Future<Map<String, dynamic>> getToken(String phone, String otp) {
    final data = apiProvider
        .post(AppRemoteRoutes.getToken, {'mobile': phone, 'token': otp});
    return data;
  }

  @override
  Future<LoginResponseModel> registerPhone(
      String phone,) async {
    var data = await apiProvider.post(
        AppRemoteRoutes.phone_auth, {'mobile': phone, });
    return LoginResponseModel.fromJson(data);
  }

  @override
  Future<void> addAddress(UserEntity data) async {
    apiProvider.post(AppRemoteRoutes.user, data.toJson());
  }

  @override
  Future<UserEntity> getUser() async {
    final data = await apiProvider.get(AppRemoteRoutes.user);
    return UserEntity.fromJson(data["user"]);
  }
}

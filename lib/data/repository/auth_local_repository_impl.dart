import 'package:grocery_app/data/remote/model/region_model.dart';
import 'package:grocery_app/domain/repository/auth_local_repositary.dart';

// import '../../../core/connection_info.dart';
import '../local/data_source/auth_local_datasource.dart';

class AuthLocalRepositoryImpl extends AuthLocalRepository {
  // final ConnectionInfo connectionInfo;
  final AuthLocalDataSource localDataSource;

  AuthLocalRepositoryImpl(this.localDataSource);

  @override
  Future<String> getToken() {
    return localDataSource.getToken();
  }

  @override
  Future<void> saveToken(String token) async {
    localDataSource.saveToken(token);
  }

  @override
  Future<void> logout() async {
    localDataSource.logout();
  }

  @override
  Future<void> saveUser(Map<String, dynamic> user) async {
    localDataSource.saveUser(user);
  }

  @override
  Future<Map<String, dynamic>> getUser() {
    return localDataSource.getUser();
  }

  @override
  RegionModel? getLocation() {
    return localDataSource.getLocation();
  }

  @override
  void saveLocation(RegionModel model) {
    return localDataSource.saveLocation(model);
  }
}

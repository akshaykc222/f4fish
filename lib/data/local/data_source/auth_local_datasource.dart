import 'package:get_storage/get_storage.dart';

import '../../remote/model/region_model.dart';

abstract class AuthLocalDataSource {
  Future<String> getToken();
  Future<void> saveToken(String token);
  Future<void> logout();
  Future<void> saveUser(Map<String, dynamic> user);
  Future<Map<String, dynamic>> getUser();
  void saveLocation(RegionModel model);
  RegionModel? getLocation();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final GetStorage localStorage;

  AuthLocalDataSourceImpl(this.localStorage);

  @override
  Future<String> getToken() {
    String? token = localStorage.read('token');
    if (token != null) {
      return Future.value(token);
    } else {
      throw "Token not found";
    }
  }

  @override
  Future<void> saveToken(String token) {
    return localStorage.write("token", token);
  }

  @override
  Future<void> logout() async {
    localStorage.remove('token');
    localStorage.remove('user');
  }

  @override
  Future<void> saveUser(Map<String, dynamic> user) {
    return localStorage.write('user', user);
  }

  @override
  Future<Map<String, dynamic>> getUser() async {
    final data = await localStorage.read('user');
    print(data);
    return data;
  }

  @override
  RegionModel? getLocation() {
    if (localStorage.hasData("location")) {
      return RegionModel.fromJson(localStorage.read("location"));
    } else {
      return null;
    }
  }

  @override
  saveLocation(RegionModel model) {
    localStorage.write("location", model.toJson());
  }
}

import '../../data/remote/model/region_model.dart';

abstract class AuthLocalRepository {
  Future<String> getToken();
  Future<void> saveToken(String token);
  Future<void> saveUser(Map<String, dynamic> user);
  Future<Map<String, dynamic>> getUser();
  Future<void> logout();
  void saveLocation(RegionModel model);
  RegionModel? getLocation();
}

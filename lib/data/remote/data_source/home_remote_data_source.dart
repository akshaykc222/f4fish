import 'package:grocery_app/core/api_provider.dart';
import 'package:grocery_app/data/remote/model/home_model.dart';
import 'package:grocery_app/data/remote/model/region_model.dart';
import 'package:grocery_app/data/remote/routes.dart';
import 'package:grocery_app/domain/entity/home_entity.dart';

abstract class HomeRemoteDataSource {
  Future<HomeEntity> getHome(int region);
  Future<List<RegionModel>> getAllLocations({String? pinCode});
  Future<RegionModel> getNearestLocation(String lat, String long);
}

class HomeRemoteDataSourceImpl extends HomeRemoteDataSource {
  final ApiProvider apiProvider;

  HomeRemoteDataSourceImpl(this.apiProvider);

  @override
  Future<HomeEntity> getHome(int region) async {
    final data = await apiProvider.get("${AppRemoteRoutes.home}$region/");
    return HomeModel.fromJson(data);
  }

  @override
  Future<List<RegionModel>> getAllLocations({String? pinCode}) async {
    String url = "";
    if (pinCode == null) {
      url = AppRemoteRoutes.locations;
    } else {
      url = "${AppRemoteRoutes.locations}?search=$pinCode";
    }

    final data = await apiProvider.get(url);
    return List<RegionModel>.from(
        data['data'].map((e) => RegionModel.fromJson(e)));
  }

  @override
  Future<RegionModel> getNearestLocation(String lat, String long) async {
    final data = await apiProvider
        .post(AppRemoteRoutes.locations, {'lat': lat, 'long': long});
    return RegionModel.fromJson(data);
  }
}

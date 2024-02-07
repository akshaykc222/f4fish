import 'package:grocery_app/data/remote/data_source/home_remote_data_source.dart';
import 'package:grocery_app/data/remote/model/region_model.dart';
import 'package:grocery_app/domain/entity/home_entity.dart';
import 'package:grocery_app/domain/repository/home_repoistory.dart';

class HomeRepositoryImpl extends HomeRepository {
  final HomeRemoteDataSource dataSource;

  HomeRepositoryImpl(this.dataSource);

  @override
  Future<HomeEntity> getHome(int region) async {
    return dataSource.getHome(region);
  }

  @override
  Future<List<RegionModel>> getAllLocations({String? pinCode}) {
    return dataSource.getAllLocations(pinCode: pinCode);
  }

  @override
  Future<RegionModel> getNearestLocation(String lat, String long) {
    return dataSource.getNearestLocation(lat, long);
  }
}

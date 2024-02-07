import 'package:grocery_app/core/usecase.dart';
import 'package:grocery_app/data/remote/model/region_model.dart';

import '../repository/home_repoistory.dart';

class GetAllLocationsUseCase extends UseCase<List<RegionModel>, String?> {
  final HomeRepository repository;

  GetAllLocationsUseCase(this.repository);

  @override
  Future<List<RegionModel>> call(String? params) {
    return repository.getAllLocations(pinCode: params);
  }
}

class GetNearestLocation extends UseCase<RegionModel, Map<String, String>> {
  final HomeRepository repository;

  GetNearestLocation(this.repository);

  @override
  Future<RegionModel> call(Map<String, String> params) {
    return repository.getNearestLocation(
        params['lat'] ?? "", params['long'] ?? "");
  }
}

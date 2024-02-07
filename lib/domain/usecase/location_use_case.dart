import 'package:grocery_app/core/usecase.dart';
import 'package:grocery_app/data/remote/model/region_model.dart';
import 'package:grocery_app/domain/repository/auth_local_repositary.dart';

class GetLocalLocationUseCase extends NoFutureUseCase<RegionModel?, NoParams> {
  final AuthLocalRepository repository;

  GetLocalLocationUseCase(this.repository);

  @override
  RegionModel? call(NoParams params) {
    return repository.getLocation();
  }
}

class SaveLocationUseCase extends NoFutureUseCase<NoParams, RegionModel> {
  final AuthLocalRepository repository;

  SaveLocationUseCase(this.repository);

  @override
  NoParams call(RegionModel params) {
    repository.saveLocation(params);
    return NoParams();
  }
}

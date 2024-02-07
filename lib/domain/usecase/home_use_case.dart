import 'package:grocery_app/core/usecase.dart';
import 'package:grocery_app/domain/entity/home_entity.dart';
import 'package:grocery_app/domain/repository/home_repoistory.dart';

class HomeUseCase extends UseCase<HomeEntity, int> {
  final HomeRepository repository;

  HomeUseCase(this.repository);

  @override
  Future<HomeEntity> call(int params) {
    return repository.getHome(params);
  }
}

import 'package:grocery_app/core/usecase.dart';
import 'package:grocery_app/domain/entity/category_entity.dart';
import 'package:grocery_app/domain/repository/category_data_repository.dart';

class SubCategoryUseCase extends UseCase<CategoryEntity, int> {
  final CategoryDataRepository repository;

  SubCategoryUseCase(this.repository);

  @override
  Future<CategoryEntity> call(int params) {
    return repository.getSubCategories(params);
  }
}

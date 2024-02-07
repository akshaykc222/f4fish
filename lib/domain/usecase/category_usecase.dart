import 'package:grocery_app/core/usecase.dart';
import 'package:grocery_app/data/remote/model/category_model.dart';
import 'package:grocery_app/domain/entity/category_entity.dart';
import 'package:grocery_app/domain/repository/category_data_repository.dart';

class CategoryUseCase extends UseCase<CategoryEntity, NoParams> {
  final CategoryDataRepository repository;

  CategoryUseCase(this.repository);

  @override
  Future<CategoryModel> call(NoParams params) {
    return repository.getCategories();
  }
}

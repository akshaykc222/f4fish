import '../../data/remote/model/category_model.dart';

abstract class CategoryDataRepository {
  Future<CategoryModel> getCategories();
  Future<CategoryModel> getSubCategories(int catId);
}

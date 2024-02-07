import 'package:grocery_app/core/api_provider.dart';
import 'package:grocery_app/data/remote/model/category_model.dart';
import 'package:grocery_app/data/remote/routes.dart';

abstract class CategoryRemoteDataSource {
  Future<CategoryModel> getCategories();
  Future<CategoryModel> getSubCategories(int catId);
}

class CategoryRemoteDataSourceImpl extends CategoryRemoteDataSource {
  final ApiProvider apiProvider;

  CategoryRemoteDataSourceImpl(this.apiProvider);

  @override
  Future<CategoryModel> getCategories() async {
    final data = await apiProvider.get(AppRemoteRoutes.category);
    print(data);
    return CategoryModel.fromJson(data);
  }

  @override
  Future<CategoryModel> getSubCategories(int catId) async {
    final data = await apiProvider.get("${AppRemoteRoutes.category}$catId/");
    return CategoryModel.fromJson(data);
  }
}

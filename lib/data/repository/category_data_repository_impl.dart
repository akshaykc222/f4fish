import 'package:grocery_app/data/remote/data_source/category_data_source.dart';
import 'package:grocery_app/data/remote/model/category_model.dart';
import 'package:grocery_app/domain/repository/category_data_repository.dart';

class CategoryDataRepositoryImpl extends CategoryDataRepository {
  final CategoryRemoteDataSource dataSource;

  CategoryDataRepositoryImpl(this.dataSource);

  @override
  Future<CategoryModel> getCategories() {
    return dataSource.getCategories();
  }

  @override
  Future<CategoryModel> getSubCategories(int catId) {
    return dataSource.getSubCategories(catId);
  }
}

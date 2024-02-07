import 'package:grocery_app/domain/entity/category_entity.dart';

class CategoryModel extends CategoryEntity {
  CategoryModel({required List<Category> categories})
      : super(categories: categories);

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
      categories:
          List<Category>.from(json['data'].map((x) => Category.fromJson(x))));
}

import 'package:grocery_app/domain/entity/ProductEntity.dart';
import 'package:grocery_app/domain/repository/product_repository.dart';

class GetProductUseCase {
  final ProductRepository repository;

  GetProductUseCase(this.repository);

  Future<List<ProductEntity>> call(
      {String? search, int? category, required int page}) {
    return repository.getProducts(
        search: search, category: category, page: page);
  }
}

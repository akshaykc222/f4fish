import 'package:grocery_app/core/usecase.dart';
import 'package:grocery_app/domain/entity/ProductEntity.dart';
import 'package:grocery_app/domain/repository/product_repository.dart';

class ProductExpandUseCase extends UseCase<ProductEntity, int> {
  final ProductRepository repository;

  ProductExpandUseCase(this.repository);

  @override
  Future<ProductEntity> call(int params) {
    return repository.getProductDetails(params);
  }
}

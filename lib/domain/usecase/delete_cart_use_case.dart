import 'package:grocery_app/core/usecase.dart';
import 'package:grocery_app/domain/repository/product_repository.dart';

import '../entity/cart_entity.dart';

class DeleteCartUseCase extends UseCase<CartData, int> {
  final ProductRepository repository;

  DeleteCartUseCase(this.repository);

  @override
  Future<CartData> call(int params) {
    return repository.deleteCartProduct(params);
  }
}

import 'package:grocery_app/core/usecase.dart';
import 'package:grocery_app/domain/entity/cart_entity.dart';
import 'package:grocery_app/domain/repository/product_repository.dart';

class AddCartUseCase extends UseCase<CartData, CartData> {
  final ProductRepository repository;

  AddCartUseCase(this.repository);

  @override
  Future<CartData> call(CartData data) {
    return repository.addCart(data);
  }
}

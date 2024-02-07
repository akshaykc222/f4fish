import 'package:grocery_app/core/usecase.dart';
import 'package:grocery_app/domain/entity/cart_entity.dart';
import 'package:grocery_app/domain/repository/product_repository.dart';

class GetCartUseCase extends UseCase<CartEntity, NoParams> {
  final ProductRepository repository;

  GetCartUseCase(this.repository);

  @override
  Future<CartEntity> call(NoParams params) async {
    final data = await repository.getCart();
    print(data.data.products.length);
    return data;
  }
}

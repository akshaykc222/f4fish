import 'package:grocery_app/core/usecase.dart';
import 'package:grocery_app/data/remote/model/order_create_model.dart';
import 'package:grocery_app/domain/repository/product_repository.dart';

class OrderCreateUseCase extends UseCase<void, OrderCreateModel> {
  final ProductRepository repository;

  OrderCreateUseCase(this.repository);

  @override
  Future<void> call(OrderCreateModel params) {
    return repository.orderProducts(params);
  }
}

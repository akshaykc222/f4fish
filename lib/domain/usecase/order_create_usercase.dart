import 'package:grocery_app/core/usecase.dart';
import 'package:grocery_app/data/remote/model/order_create_model.dart';
import 'package:grocery_app/domain/repository/product_repository.dart';

import '../../data/remote/model/order_model.dart';

class OrderCreateUseCase extends UseCase<OrderData, OrderCreateModel> {
  final ProductRepository repository;

  OrderCreateUseCase(this.repository);

  @override
  Future<OrderData> call(OrderCreateModel params) {
    return repository.orderProducts(params);
  }
}

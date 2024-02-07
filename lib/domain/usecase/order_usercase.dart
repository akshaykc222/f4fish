import 'package:grocery_app/core/usecase.dart';
import 'package:grocery_app/data/remote/model/order_model.dart';
import 'package:grocery_app/domain/repository/product_repository.dart';

class OrderUseCase extends UseCase<OrderModel, NoParams> {
  final ProductRepository repository;

  OrderUseCase(this.repository);

  @override
  Future<OrderModel> call(NoParams params) {
    return repository.getOrders();
  }
}

class OrderStaffUseCase {
  final ProductRepository repository;

  OrderStaffUseCase(this.repository);

  @override
  Future<OrderModel> call(int region, {String? filter}) {
    return repository.getStaffOrders(region, filter: filter);
  }
}

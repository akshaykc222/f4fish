import 'package:grocery_app/domain/repository/product_repository.dart';

class UpdateOrderUseCase {
  final ProductRepository repository;

  UpdateOrderUseCase(this.repository);

  @override
  Future<void> call(String orderId, Map<String, dynamic> params) {
    return repository.updateOrders(orderId, params);
  }
}

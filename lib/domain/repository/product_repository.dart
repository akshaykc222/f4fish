import 'package:grocery_app/data/remote/model/order_create_model.dart';
import 'package:grocery_app/domain/entity/ProductEntity.dart';

import '../../data/remote/model/order_model.dart';
import '../entity/cart_entity.dart';

abstract class ProductRepository {
  Future<List<ProductEntity>> getProducts(
      {String? search, int? category, required int page});
  Future<ProductEntity> getProductDetails(int id);
  Future<CartEntity> getCart();
  Future<CartData> addCart(CartData data);
  Future<CartData> deleteCartProduct(int id);
  Future<void> orderProducts(OrderCreateModel orderCreateModel);
  Future<OrderModel> getOrders();
  Future<void> updateOrders(String orderId, Map<String, dynamic> data);
  Future<OrderModel> getStaffOrders(int region, {String? filter});
}

import 'package:grocery_app/data/remote/data_source/products_remote_data_source.dart';
import 'package:grocery_app/data/remote/model/order_create_model.dart';
import 'package:grocery_app/data/remote/model/order_model.dart';
import 'package:grocery_app/domain/entity/ProductEntity.dart';
import 'package:grocery_app/domain/entity/cart_entity.dart';
import 'package:grocery_app/domain/repository/product_repository.dart';

class ProductRepositoryImpl extends ProductRepository {
  final ProductRemoteDataUseCase dataSource;

  ProductRepositoryImpl(this.dataSource);

  @override
  Future<List<ProductEntity>> getProducts(
      {String? search, int? category, required int page}) {
    return dataSource.getProducts(
        search: search, category: category, page: page);
  }

  @override
  Future<ProductEntity> getProductDetails(int id) {
    return dataSource.getProductDetail(id);
  }

  @override
  Future<CartData> addCart(CartData data) {
    return dataSource.addCart(data);
  }

  @override
  Future<CartData> deleteCartProduct(int id) {
    return dataSource.deleteCartProduct(id);
  }

  @override
  Future<CartEntity> getCart() {
    return dataSource.getCart();
  }

  @override
  Future<OrderModel> getOrders() {
    return dataSource.getOrders();
  }

  @override
  Future<void> orderProducts(OrderCreateModel orderCreateModel) {
    return dataSource.orderProducts(orderCreateModel);
  }

  @override
  Future<OrderModel> getStaffOrders(int region, {String? filter}) {
    return dataSource.getStaffOrders(region, filter: filter);
  }

  @override
  Future<void> updateOrders(String orderId, Map<String, dynamic> data) {
    return dataSource.updateOrders(orderId, data);
  }
}

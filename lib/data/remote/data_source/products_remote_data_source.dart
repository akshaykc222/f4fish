import 'package:flutter/widgets.dart';
import 'package:grocery_app/core/api_provider.dart';
import 'package:grocery_app/data/remote/model/order_create_model.dart';
import 'package:grocery_app/data/remote/model/product_model.dart';
import 'package:grocery_app/data/remote/routes.dart';

import '../../../domain/entity/ProductEntity.dart';
import '../../../domain/entity/cart_entity.dart';
import '../model/order_model.dart';

abstract class ProductRemoteDataUseCase {
  Future<List<ProductEntity>> getProducts(
      {String? search, int? category, required int page});
  Future<List<ProductEntity>> getFavorites();
  Future adFav({required int id});
  Future<ProductEntity> getProductDetail(int id);
  Future<CartEntity> getCart();
  Future<CartData> addCart(CartData data);
  Future<CartData> deleteCartProduct(int id);
  Future<OrderData> orderProducts(OrderCreateModel orderCreateModel);
  Future<OrderModel> getOrders();
  Future<void> updateOrders(String orderId, Map<String, dynamic> data);
  Future<OrderModel> getStaffOrders(int region, {String? filter});
}

class ProductRemoteDataUseCaseImpl extends ProductRemoteDataUseCase {
  final ApiProvider apiProvider;

  ProductRemoteDataUseCaseImpl(this.apiProvider);

  @override
  Future<ProductEntity> getProductDetail(int id) async {
    final data = await apiProvider.get("${AppRemoteRoutes.products}/$id/");
    debugPrint(data.toString());
    return ProductModel.fromJson(data);
  }

  @override
  Future<CartData> addCart(CartData data) async {
    final res = await apiProvider.post(AppRemoteRoutes.cart, data.toJson());
    return CartData.fromJson(res);
  }

  @override
  Future<CartData> deleteCartProduct(int id) async {
    final res = await apiProvider.delete(
      "${AppRemoteRoutes.cart}$id/",
    );
    return CartData.fromJson(res);
  }

  @override
  Future<CartEntity> getCart() async {
    final res = await apiProvider.get(AppRemoteRoutes.cart);
    final data = CartEntity.fromJson(res);
    print("response length cart ${data.data.products.length}");
    return data;
  }

  @override
  Future<OrderModel> getOrders() async {
    final data = await apiProvider.get(AppRemoteRoutes.orders);
    return OrderModel.fromJson(data);
  }

  @override
  Future<OrderData> orderProducts(OrderCreateModel orderCreateModel) async {
    if (orderCreateModel.id != null) {
      final data = await apiProvider.put(
          "${AppRemoteRoutes.order_create}?id=${orderCreateModel.id}/",
          orderCreateModel.toJson(updatePayment: true));
      debugPrint(data.toString());
      return OrderData.fromJson(data);
    } else {
      final data = await apiProvider.post(
          AppRemoteRoutes.order_create, orderCreateModel.toJson());
      debugPrint(data.toString());
      return OrderData.fromJson(data);
    }
  }

  @override
  Future<List<ProductEntity>> getProducts(
      {String? search, int? category, required int page}) async {
    String url = AppRemoteRoutes.products;
    if (search != null && category != null) {
      url = "${AppRemoteRoutes.products}?category=$category&search=$search";
    } else if (search != null) {
      url = "${AppRemoteRoutes.products}?search=$search";
    } else if (category != null) {
      url = "${AppRemoteRoutes.products}?category=$category";
    } else {
      url = "${AppRemoteRoutes.products}";
    }
    print(url);
    final data = await apiProvider.get(url);
    return List<ProductEntity>.from(
        data['results'].map((x) => ProductModel.fromJson(x)));
  }

  @override
  Future<OrderModel> getStaffOrders(int region, {String? filter}) async {
    print("${AppRemoteRoutes.orders}?$filter  -$region");
    final data = await apiProvider.get(
      "${AppRemoteRoutes.orders}?$filter",
    );
    return OrderModel.fromJson(data);
  }

  @override
  Future<void> updateOrders(String orderId, Map<String, dynamic> data) async {
    final d =
        await apiProvider.patch("${AppRemoteRoutes.orders}/$orderId/", data);
  }

  @override
  Future<List<ProductEntity>> getFavorites() async {
    final data = await apiProvider.get(AppRemoteRoutes.fav);
    return List<ProductEntity>.from(
        data['results'].map((x) => ProductModel.fromJson(x)));
  }

  @override
  Future adFav({required int id}) async {
    final data = await apiProvider.post(AppRemoteRoutes.fav, {"id": id});
  }
}

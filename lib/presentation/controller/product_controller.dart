import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:grocery_app/core/response_classify.dart';
import 'package:grocery_app/core/usecase.dart';
import 'package:grocery_app/data/remote/model/order_create_model.dart';
import 'package:grocery_app/data/remote/model/order_model.dart';
import 'package:grocery_app/domain/entity/ProductEntity.dart';
import 'package:grocery_app/domain/usecase/get_expand_product_usecase.dart';
import 'package:grocery_app/domain/usecase/get_product_usecase.dart';
import 'package:grocery_app/domain/usecase/upate_order_usecase.dart';
import 'package:progress_state_button/progress_button.dart';

import '../../domain/usecase/location_use_case.dart';
import '../../domain/usecase/order_create_usercase.dart';
import '../../domain/usecase/order_usercase.dart';

class ProductController extends GetxController {
  final GetProductUseCase getProductUseCase;
  final ProductExpandUseCase productExpandUseCase;
  final OrderCreateUseCase orderCreateUseCase;
  final OrderUseCase orderUseCase;
  final UpdateOrderUseCase updateOrderUseCase;

  final GetLocalLocationUseCase getLocation;
  final OrderStaffUseCase orderStaffUseCase;
  ProductController(
      this.getProductUseCase,
      this.productExpandUseCase,
      this.orderCreateUseCase,
      this.orderUseCase,
      this.orderStaffUseCase,
      this.getLocation,
      this.updateOrderUseCase);
  final expandResponse = ResponseClassify<ProductEntity>.loading().obs;
  getProductExpandDetails(int id) async {
    expandResponse.value = ResponseClassify.loading();

    expandResponse.value =
        ResponseClassify.completed(await productExpandUseCase.call(id));
    selectedQuantity.value = expandResponse.value.data?.quantityType.first;
    if (expandResponse.value.data?.images?.isNotEmpty == true) {
      thumbImage.value = expandResponse.value.data?.images?.first.image ?? "";
    }

    changeTotal();
    print(expandResponse.value.data?.images?.length);
  }

  final selectedQuantity = Rxn<QuantityVariant>();

  setQuantity(QuantityVariant variant) {
    selectedQuantity.value = variant;
  }

  final quantityCount = 1.obs;

  final totalAmount = 0.0.obs;

  void changeTotal() {
    totalAmount.value =
        ((expandResponse.value.data?.quantityType.first.sellingPrice ?? 0) *
            quantityCount.value);
  }

  incrementQuantity() {
    debugPrint("changing quantity ${quantityCount.value}");
    quantityCount.value = quantityCount.value + 1;
    changeTotal();
  }

  decrementQuantity() {
    if (!(quantityCount.value < 1)) {
      quantityCount.value -= 1;
      changeTotal();
    }
  }
  //cart button state

  final buttonState = ButtonState.idle.obs;

  addToCart() {
    debugPrint("clicking");
    buttonState.value = ButtonState.loading;
    Future.delayed(Duration(seconds: 30), () {
      buttonState.value = ButtonState.success;
    });
  }
  // final productsUse

  final orderCreateResponse = ResponseClassify<void>.error("").obs;
  final orderUpdateResponse = ResponseClassify.error("").obs;

  updateOrders(String orderId, Map<String, dynamic> data) {
    orderUpdateResponse.value = ResponseClassify.loading();
    try {
      orderUpdateResponse.value =
          ResponseClassify.completed(updateOrderUseCase.call(orderId, data));
      getOrders();
    } catch (e) {
      orderUpdateResponse.value = ResponseClassify.error(e.toString());
    }
  }

  orderProducts(OrderCreateModel model) async {
    print(model.toJson());
    orderCreateResponse.value = ResponseClassify.loading();
    try {
      orderCreateResponse.value =
          ResponseClassify.completed(await orderCreateUseCase.call(model));
    } catch (e) {
      orderCreateResponse.value = ResponseClassify.error(e.toString());
    }
  }

  final orderResponse = ResponseClassify<OrderModel>.loading().obs;

  getOrders() async {
    orderResponse.value = ResponseClassify.loading();
    try {
      orderResponse.value =
          ResponseClassify.completed(await orderUseCase.call(NoParams()));
    } catch (e) {
      orderResponse.value = ResponseClassify.error(e.toString());
      debugPrint("[data]=> ${e.toString()}");
    }
  }

  final orderStaffResponse = ResponseClassify<OrderModel>.loading().obs;

  getStaffOrders({String? filter}) async {
    var d = getLocation.call(NoParams());
    if (d != null) {
      orderStaffResponse.value = ResponseClassify.loading();
      try {
        debugPrint("id${d.id}");
        orderStaffResponse.value = ResponseClassify.completed(
            await orderStaffUseCase.call(d.id, filter: filter));
      } catch (e) {
        orderStaffResponse.value = ResponseClassify.error(e.toString());
        debugPrint("[data]=> ${e.toString()}");
      }
    }
  }

  final productsAllResponse =
      ResponseClassify<List<ProductEntity>>.completed([]).obs;

  final page = 1.obs;
  getAllProducts({int? category, String? search}) async {
    productsAllResponse.value = ResponseClassify.loading();
    try {
      productsAllResponse.value = ResponseClassify.completed(
          await getProductUseCase.call(
              category: category, search: search, page: page.value));
      page.value++;
    } catch (e) {
      page.value = 1;
      productsAllResponse.value = ResponseClassify.error(e.toString());
      debugPrint("[data]=> ${e.toString()}");
    }
  }

  var thumbImage = "".obs;
  changeThumbnail(String image) {
    thumbImage.value = image;
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/domain/entity/cart_entity.dart';
import 'package:grocery_app/domain/entity/user_entity.dart';
import 'package:grocery_app/presentation/controller/home_controller.dart';
import 'package:grocery_app/presentation/time_slots.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../core/response_classify.dart';
import '../data/remote/model/order_create_model.dart';
import '../data/remote/model/payment_model.dart';
import '../injecter.dart';
import '../presentation/controller/auth_controller.dart';
import '../presentation/controller/cart_controller.dart';
import '../presentation/controller/product_controller.dart';
import '../presentation/screens/order_accepted_screen.dart';

void doPayment(
    {required BuildContext context,
    double? amount,
    required CartData model,
    required UserEntity user}) {
  final productController =
      Get.put(ProductController(sl(), sl(), sl(), sl(), sl(), sl(), sl()));
  final authController = Get.find<AuthController>();
  final cartController = Get.find<CartController>();
  final homeController = Get.find<HomeController>();
  Razorpay razorpay = Razorpay();
  var options = {
    'key': 'rzp_live_ILgsfZCZoFIKMb',
    'amount': amount,
    'name': model.products.map((e) => e.product.name).toString(),
    'description': "",
    'retry': {'enabled': true, 'max_count': 1},
    'send_sms_hash': true,
    'prefill': {'contact': user.name, 'email': user.email ?? "test@gmail.com"},
    'external': {
      'wallets': ['paytm']
    }
  };
  try {
    razorpay.open(options);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR,
        (PaymentFailureResponse response) async {
      await productController.orderProducts(OrderCreateModel(
          cart: cartController.cartList.value!.data.id!,
          address: authController.selectedAddress.value!.id!,
          paymentRef: PaymentModel(
              status: "FAILED",
              transactionId: "",
              type: "ONLINE",
              orderAmount: cartController.cartList.value?.data.total ?? 0.0,
              id: null),
          status: "FAILED",
          comments: response.message,
          region: homeController.location.value!.id,
          timeSlot: selectedDate.value?.id ?? 1));

      if (productController.orderCreateResponse.value.status ==
          Status.COMPLETED) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) {
            return OrderAcceptedScreen();
          },
        ));
      } else if (productController.orderCreateResponse.value.status ==
          Status.ERROR) {
        Get.snackbar("ERROR",
            productController.orderCreateResponse.value.error.toString());
      }
    });
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
        (PaymentSuccessResponse response) async {
      await productController.orderProducts(OrderCreateModel(
          cart: cartController.cartList.value!.data.id!,
          address: authController.selectedAddress.value!.id!,
          paymentRef: PaymentModel(
              status: "SUCCESS",
              transactionId: response.paymentId ?? "",
              type: "ONLINE",
              orderAmount: cartController.cartList.value?.data.total ?? 0.0,
              id: null),
          status: "PENDING",
          comments: cartController.noteController.text,
          region: homeController.location.value!.id,
          timeSlot: selectedDate.value?.id ?? 1));

      if (productController.orderCreateResponse.value.status ==
          Status.COMPLETED) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) {
            return OrderAcceptedScreen();
          },
        ));
      } else if (productController.orderCreateResponse.value.status ==
          Status.ERROR) {
        Get.snackbar("ERROR",
            productController.orderCreateResponse.value.error.toString());
      }
    });
  } catch (e) {
    print(e);
  }
}

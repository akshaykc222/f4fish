import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/app_constants.dart';
import 'package:grocery_app/data/remote/routes.dart';
import 'package:grocery_app/domain/entity/cart_entity.dart';
import 'package:grocery_app/domain/entity/user_entity.dart';
import 'package:grocery_app/presentation/controller/home_controller.dart';
import 'package:phonepe_payment_sdk/phonepe_payment_sdk.dart';

import '../core/response_classify.dart';
import '../data/remote/model/order_create_model.dart';
import '../data/remote/model/payment_model.dart';
import '../injecter.dart';
import '../presentation/controller/cart_controller.dart';
import '../presentation/controller/product_controller.dart';
import '../presentation/screens/order_accepted_screen.dart';
import '../presentation/screens/order_failed_dialog.dart';
import '../presentation/time_slots.dart';

class PhonePyPayment {
  final BuildContext context;
  final double? amount;
  final CartData model;
  final UserEntity user;
  final int selectedAddress;
  final String? comments;
  final String? tranId;
  final Function successFun;

  PhonePyPayment({
    required this.context,
    this.amount,
    required this.model,
    required this.user,
    required this.selectedAddress,
    this.tranId,
    this.comments,
    required this.successFun,
  }) {
    init().then((value) => getCheckSum());
  }

  final productController =
      Get.put(ProductController(sl(), sl(), sl(), sl(), sl(), sl(), sl()));

  final cartController = Get.find<CartController>();
  final homeController = Get.find<HomeController>();
  String checkSum = "";
  String getCheckSum() {
    String redirect = "${AppRemoteRoutes.baseUrl}api/v1/phonepe_callback/";
    var requestData = {
      "merchantId": PaymentInfo.merchantId,
      "merchantTransactionId": tranId ?? "",
      "merchantUserId": user.id,
      "amount": amount != null
          ? (amount! * 100).toInt()
          : 0, // Convert amount to paise
      "redirectUrl": redirect,
      "redirectMode": "REDIRECT",
      "callbackUrl": redirect,
      "mobileNumber": user.mobile,
      "paymentInstrument": {"type": "PAY_PAGE"}
    };

    String base64String = base64.encode(utf8.encode(json.encode(requestData)));
    checkSum =
        '${sha256.convert(utf8.encode(base64String + PaymentInfo.apiEndPoint + PaymentInfo.saltKey)).toString()}###${PaymentInfo.saltIndex}';
    return base64String;
  }

  bool instanceCreated = false;

  Future<bool> init() async {
    debugPrint("INSTANCE CREATED");
    return instanceCreated = await PhonePePaymentSdk.init(PaymentInfo.env,
        PaymentInfo.appId, PaymentInfo.merchantId, PaymentInfo.enableLogging);
  }

  int retry = 3;
  void callApi(
      {required String sts,
      required String tranId,
      required String message,
      required String orderSts}) async {
    await productController.orderProducts(OrderCreateModel(
        cart: cartController.cartList.value!.data.id!,
        address: selectedAddress,
        paymentRef: PaymentModel(
            status: sts,
            transactionId: tranId,
            type: "ONLINE_TRANSACTION",
            orderAmount: cartController.cartList.value?.data.total ?? 0.0,
            id: null),
        status: sts,
        comments: sts != "FAILED" ? message : comments,
        region: homeController.location.value!.id,
        timeSlot: selectedDate.value?.id ?? 1));
    // productController.updateOrderUseCase.call(
    //     productController.orderCreateResponse.value.data!.id!,
    //
    //         .toJson(updatePayment: true));
    if (sts != "FAILED") {
      if (productController.orderCreateResponse.value.status ==
          Status.COMPLETED) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) {
            return OrderAcceptedScreen();
          },
        ));
      } else if (productController.orderCreateResponse.value.status ==
          Status.ERROR) {
        showDialog(
            context: context,
            builder: (context) => OrderFailedDialogue(
                message: "Something went wrong.",
                tryAgain: () {
                  doPayment();
                }));
      }
    } else {
      showDialog(
          context: context,
          builder: (context) => OrderFailedDialogue(
                message: message,
                tryAgain: () {
                  doPayment();
                },
              ));
    }
  }

  doPayment() async {
    if (instanceCreated) {
      var body = getCheckSum().toString();
      print("STARTING TRANSACTION $body");
      PhonePePaymentSdk.startTransaction(
              body, "flutterDemoApp", checkSum, "com.f4fish.client_app")
          .then((value) {
        print("trans:${value!['status']}");
        print(value);
        if (value!['status'] == "SUCCESS") {
          successFun();
        } else {
          showDialog(
              context: context,
              builder: (context) => OrderFailedDialogue(
                  message: "Something went wrong.",
                  tryAgain: () {
                    doPayment();
                  }));
        }
        print(value);
      }).catchError((error) {
        print(error);
        showDialog(
            context: context,
            builder: (context) => OrderFailedDialogue(
                message: "$error",
                tryAgain: () {
                  doPayment();
                }));
      });
    } else {
      await init();
      if (retry > 0) {
        retry--;
      }

      if (retry != 0) {
        print("DOING RETRY $retry");
        doPayment();
      }
    }
  }
}

// void doPayment(
//     {required BuildContext context,
//     double? amount,
//     required CartData model,
//     required UserEntity user}) {
//
//   String checkSum = "";
//   String saltKey = "099eb0cd-02cf-4e2a-8aca-3e6c6aff0399";
//   String saltIndex = "1";
//   String callbackUrl =
//       "https://webhook.site/0fc14574-b4c2-4dc5-8fdb-29fc43c45d46";
//   String body = "";
//
//
//   Razorpay razorpay = Razorpay();
//   var options = {
//     'key': 'rzp_live_ILgsfZCZoFIKMb',
//     'amount': amount,
//     'name': model.products.map((e) => e.product.name).toString(),
//     'description': "",
//     'retry': {'enabled': true, 'max_count': 1},
//     'send_sms_hash': true,
//     'prefill': {'contact': user.name, 'email': user.email ?? "test@gmail.com"},
//     'external': {
//       'wallets': ['paytm']
//     }
//   };
//   try {
//     razorpay.open(options);
//     razorpay.on(Razorpay.EVENT_PAYMENT_ERROR,
//         (PaymentFailureResponse response) async {
//       await productController.orderProducts(OrderCreateModel(
//           cart: cartController.cartList.value!.data.id!,
//           address: authController.selectedAddress.value!.id!,
//           paymentRef: PaymentModel(
//               status: "FAILED",
//               transactionId: "",
//               type: "ONLINE",
//               orderAmount: cartController.cartList.value?.data.total ?? 0.0,
//               id: null),
//           status: "FAILED",
//           comments: response.message,
//           region: homeController.location.value!.id,
//           timeSlot: selectedDate.value?.id ?? 1));
//
//       if (productController.orderCreateResponse.value.status ==
//           Status.COMPLETED) {
//         Navigator.of(context).pushReplacement(MaterialPageRoute(
//           builder: (BuildContext context) {
//             return OrderAcceptedScreen();
//           },
//         ));
//       } else if (productController.orderCreateResponse.value.status ==
//           Status.ERROR) {
//         showDialog(
//             context: context, builder: (context) => OrderFailedDialogue());
//       }
//     });
//     razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
//         (PaymentSuccessResponse response) async {
//       await productController.orderProducts(OrderCreateModel(
//           cart: cartController.cartList.value!.data.id!,
//           address: authController.selectedAddress.value!.id!,
//           paymentRef: PaymentModel(
//               status: "SUCCESS",
//               transactionId: response.paymentId ?? "",
//               type: "ONLINE",
//               orderAmount: cartController.cartList.value?.data.total ?? 0.0,
//               id: null),
//           status: "PENDING",
//           comments: cartController.noteController.text,
//           region: homeController.location.value!.id,
//           timeSlot: selectedDate.value?.id ?? 1));
//
//       if (productController.orderCreateResponse.value.status ==
//           Status.COMPLETED) {
//         Navigator.of(context).pushReplacement(MaterialPageRoute(
//           builder: (BuildContext context) {
//             return OrderAcceptedScreen();
//           },
//         ));
//       } else if (productController.orderCreateResponse.value.status ==
//           Status.ERROR) {
//         Get.snackbar("ERROR",
//             productController.orderCreateResponse.value.error.toString());
//       }
//     });
//   } catch (e) {
//     print(e);
//   }
// }

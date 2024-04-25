import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/common_widgets/app_button.dart';
import 'package:grocery_app/common_widgets/app_text.dart';
import 'package:grocery_app/common_widgets/payment.dart';
import 'package:grocery_app/core/response_classify.dart';
import 'package:grocery_app/data/remote/model/order_create_model.dart';
import 'package:grocery_app/data/remote/model/payment_model.dart';
import 'package:grocery_app/presentation/controller/auth_controller.dart';
import 'package:grocery_app/presentation/controller/product_controller.dart';
import 'package:grocery_app/presentation/styles/colors.dart';
import 'package:grocery_app/presentation/time_slots.dart';
import 'package:uuid/uuid.dart';

import '../../injecter.dart';
import '../controller/cart_controller.dart';
import '../controller/home_controller.dart';
import 'order_accepted_screen.dart';

class OrderFailedDialogue extends StatelessWidget {
  final String? message;
  final Function tryAgain;

  OrderFailedDialogue({this.message, required this.tryAgain});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
      insetPadding: EdgeInsets.symmetric(horizontal: 25),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 25,
        ),
        height: 600.0,
        width: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(
                vertical: 20,
              ),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.close,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
            Spacer(
              flex: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 45,
              ),
              child: Image(
                  image: AssetImage("assets/images/order_failed_image.png")),
            ),
            Spacer(
              flex: 5,
            ),
            AppText(
              text: "Oops! Order Failed",
              fontSize: 28,
              fontWeight: FontWeight.w600,
            ),
            Spacer(
              flex: 2,
            ),
            AppText(
              text: message ?? "Something went temply wrong",
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xff7C7C7C),
            ),
            Spacer(
              flex: 8,
            ),
            AppButton(
              label: "Please Try Again",
              fontWeight: FontWeight.w600,
              onPressed: () => tryAgain(),
            ),
            Spacer(
              flex: 4,
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: AppText(
                text: "Back To Home",
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            Spacer(
              flex: 4,
            ),
          ],
        ),
      ),
    );
  }
}

class OrderWarningDialogue extends StatefulWidget {
  @override
  State<OrderWarningDialogue> createState() => _OrderWarningDialogueState();
}

class _OrderWarningDialogueState extends State<OrderWarningDialogue> {
  final productController =
      Get.put(ProductController(sl(), sl(), sl(), sl(), sl(), sl(), sl()));
  final authController = Get.find<AuthController>();
  final cartController = Get.find<CartController>();
  final homeController = Get.find<HomeController>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      homeController.getLocalLocation();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
      insetPadding: EdgeInsets.symmetric(horizontal: 25),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 25,
        ),
        height: 600.0,
        width: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(
                vertical: 20,
              ),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.close,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
            Spacer(
              flex: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 45,
              ),
              child: Image(
                  image: AssetImage("assets/images/order_failed_image.png")),
            ),
            Spacer(
              flex: 5,
            ),
            AppText(
              text: "Please Note !",
              fontSize: 28,
              fontWeight: FontWeight.w600,
            ),
            Spacer(
              flex: 2,
            ),
            AppText(
              text: "Order can not be cancelled once placed!",
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xff7C7C7C),
            ),
            Spacer(
              flex: 8,
            ),
            Obx(() => productController.orderCreateResponse.value.status ==
                    Status.LOADING
                ? Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    ),
                  )
                : AppButton(
                    label: "Ok,Proceed",
                    fontWeight: FontWeight.w600,
                    onPressed: () async {
                      if (authController.selectedAddress.value == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Please select address")));
                      } else if (homeController.location.value?.id == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Please select Location")));
                      } else {
                        print(
                            "CREATING ORDER ${cartController.selectedPaymentType.value}");
                        if (cartController.selectedPaymentType.value == "COD") {
                          await productController.orderProducts(
                              OrderCreateModel(
                                  cart: cartController.cartList.value!.data.id!,
                                  address:
                                      authController.selectedAddress.value!.id!,
                                  paymentRef: PaymentModel(
                                      status: "SUCCESS",
                                      transactionId: Uuid().v4(),
                                      type: "COD",
                                      orderAmount: cartController
                                              .cartList.value?.data.total ??
                                          0.0,
                                      id: null),
                                  status: "ORDERED",
                                  comments: cartController.noteController.text,
                                  region: homeController.location.value!.id,
                                  timeSlot: selectedDate.value?.id ?? 1));
                          if (productController
                                  .orderCreateResponse.value.status ==
                              Status.COMPLETED) {
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                              builder: (BuildContext context) {
                                return OrderAcceptedScreen();
                              },
                            ));
                          } else if (productController
                                  .orderCreateResponse.value.status ==
                              Status.ERROR) {
                            Get.snackbar(
                                "ERROR",
                                productController
                                    .orderCreateResponse.value.error
                                    .toString());
                          }
                        } else {
                          if (authController.getUserDataResponse.value.data ==
                              null) {
                            await authController.getUserData();
                          }

                          print("DOING ONLINE PAYMENT");
                          if (productController
                                  .orderCreateResponse.value.data?.id !=
                              null) {
                            var instance = PhonePyPayment(
                                tranId: productController
                                    .orderCreateResponse.value.data?.id,
                                context: context,
                                amount:
                                    cartController.cartList.value?.data.total ??
                                        0.0,
                                model: cartController.cartList.value!.data,
                                user: authController
                                    .getUserDataResponse.value.data!,
                                selectedAddress:
                                    authController.selectedAddress.value!.id!,
                                successFun: () async {
                                  await productController.orderProducts(
                                      OrderCreateModel(
                                          cart: cartController
                                              .cartList.value!.data.id!,
                                          address:
                                              authController
                                                  .selectedAddress.value!.id!,
                                          paymentRef:
                                              PaymentModel(
                                                  status: "PENDING",
                                                  transactionId: Uuid().v4(),
                                                  type: "ONLINE_TRANSACTION",
                                                  orderAmount:
                                                      cartController
                                                              .cartList
                                                              .value
                                                              ?.data
                                                              .total ??
                                                          0.0,
                                                  id: null),
                                          status: "PENDING",
                                          comments: cartController
                                              .noteController.text,
                                          region:
                                              homeController.location.value!.id,
                                          timeSlot:
                                              selectedDate.value?.id ?? 1));
                                  Navigator.of(context)
                                      .pushReplacement(MaterialPageRoute(
                                    builder: (BuildContext context) {
                                      return OrderAcceptedScreen();
                                    },
                                  ));
                                });
                            instance.doPayment();
                          }
                        }
                      }
                    },
                  )),
            Spacer(
              flex: 4,
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: AppText(
                text: "Back To Home",
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            Spacer(
              flex: 4,
            ),
          ],
        ),
      ),
    );
  }
}

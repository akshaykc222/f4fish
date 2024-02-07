import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/common_widgets/app_button.dart';
import 'package:grocery_app/common_widgets/app_text.dart';
import 'package:grocery_app/data/remote/model/time_slot_model.dart';
import 'package:grocery_app/presentation/controller/auth_controller.dart';
import 'package:grocery_app/presentation/controller/cart_controller.dart';
import 'package:grocery_app/presentation/routes.dart';
import 'package:grocery_app/presentation/time_slots.dart';

import '../order_failed_dialog.dart';

class CheckoutBottomSheet extends StatefulWidget {
  @override
  _CheckoutBottomSheetState createState() => _CheckoutBottomSheetState();
}

class _CheckoutBottomSheetState extends State<CheckoutBottomSheet> {
  final controller = Get.find<CartController>();
  final authController = Get.find<AuthController>();
  @override
  void initState() {
    authController.getUserData();
    controller.noteController.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          padding: EdgeInsets.symmetric(
            horizontal: 25,
            vertical: 30,
          ),
          margin:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
          child: new Wrap(
            children: <Widget>[
              Row(
                children: [
                  AppText(
                    text: "Checkout",
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                  Spacer(),
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.close,
                        size: 25,
                      ))
                ],
              ),
              SizedBox(
                height: 45,
              ),
              getDivider(),
              checkoutRow("Delivery",
                  trailingWidget: TextButton(
                      onPressed: () {
                        Get.toNamed(AppRoutes.address);
                      },
                      child: Text(
                        "Change Address",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ))),
              ListTile(
                title: Text(
                  "Name : ${authController.selectedAddress.value?.name ?? ""}\nPhone Number : ${authController.selectedAddress.value?.phoneNumber ?? ""}\nAddress : ${authController.selectedAddress.value?.address ?? ''}",
                  maxLines: 4,
                ),
              ),
              getDivider(),
              checkoutRow("Payment",
                  trailingWidget: Row(
                    children: [
                      DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                            value: controller.selectedPaymentType.value,
                            icon: Icon(
                              Icons.payment,
                              color: Colors.black,
                            ),
                            items: ["COD", "ONLINE"]
                                .map((e) => DropdownMenuItem<String>(
                                    alignment: AlignmentDirectional.centerEnd,
                                    value: e,
                                    child: Text(
                                      e,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    )))
                                .toList(),
                            onChanged: (String? val) {
                              controller.changeSelectedPaymentType(val ?? "");
                            }),
                      ),
                      Icon(Icons.arrow_drop_down)
                    ],
                  )),
              // getDivider(),
              // checkoutRow("Promo Code", trailingText: "Pick Discount"),
              getDivider(),
              checkoutRow("Total Cost",
                  trailingText: controller.cartList.value!.data.total
                      ?.toStringAsFixed(2)),
              getDivider(),
              ValueListenableBuilder<TimeSlotModel?>(
                  valueListenable: selectedDate,
                  builder: (context, slot, child) {
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.timeSlots);
                      },
                      child: checkoutRow("Time Slot",
                          trailingText: slot == null
                              ? "Select"
                              : "${slot.startTime}-${slot.endTime}"),
                    );
                  }),
              getDivider(),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: TextFormField(
                  controller: controller.noteController,
                  maxLines: 4,
                  decoration: InputDecoration(hintText: 'Notes(optional)'),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              termsAndConditionsAgreement(context),
              Container(
                margin: EdgeInsets.only(
                  top: 25,
                ),
                child: AppButton(
                  label: "Place Order",
                  fontWeight: FontWeight.w600,
                  padding: EdgeInsets.symmetric(
                    vertical: 23,
                  ),
                  onPressed: () {
                    if (authController.selectedAddress.value?.name != null ||
                        authController.selectedAddress.value?.name == "") {
                      if (selectedDate.value == null) {
                        Get.toNamed(AppRoutes.timeSlots);
                      } else {
                        onPlaceOrderClicked();
                      }
                    } else {
                      Get.toNamed(AppRoutes.address);
                    }
                  },
                ),
              ),
            ],
          ),
        ));
  }

  Widget getDivider() {
    return Divider(
      thickness: 1,
      color: Color(0xFFE2E2E2),
    );
  }

  Widget termsAndConditionsAgreement(BuildContext context) {
    return RichText(
      text: TextSpan(
          text: 'By placing an order you agree to our',
          style: TextStyle(
            color: Color(0xFF7C7C7C),
            fontSize: 14,
            fontFamily: Theme.of(context).textTheme.bodyText1?.fontFamily,
            fontWeight: FontWeight.w600,
          ),
          children: [
            TextSpan(
                text: " Terms",
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold)),
            TextSpan(text: " And"),
            TextSpan(
                text: " Conditions",
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold)),
          ]),
    );
  }

  Widget checkoutRow(String label,
      {String? trailingText, Widget? trailingWidget}) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 15,
      ),
      child: Row(
        children: [
          AppText(
            text: label,
            fontSize: 18,
            color: Color(0xFF7C7C7C),
            fontWeight: FontWeight.w600,
          ),
          Spacer(),
          trailingText == null
              ? trailingWidget ?? Container()
              : AppText(
                  text: trailingText,
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
          SizedBox(
            width: 20,
          ),
          Icon(
            Icons.arrow_forward_ios,
            size: 20,
          )
        ],
      ),
    );
  }

  void onPlaceOrderClicked() {
    Navigator.pop(context);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return OrderWarningDialogue();
        });
  }
}

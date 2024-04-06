import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/common_widgets/app_text.dart';
import 'package:grocery_app/core/response_classify.dart';
import 'package:grocery_app/data/remote/model/order_model.dart';
import 'package:grocery_app/domain/entity/cart_entity.dart';
import 'package:grocery_app/presentation/controller/product_controller.dart';
import 'package:grocery_app/presentation/styles/colors.dart';

import '../../app_constants.dart';

class OrdersList extends StatelessWidget {
  const OrdersList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductController>();
    controller.getOrders();
    return Scaffold(
      appBar: AppBar(
        title: Text("Orders"),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Obx(() => controller.orderResponse.value.status == Status.LOADING
          ? Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryColor,
              ),
            )
          : controller.orderResponse.value.data!.data.isEmpty
              ? Center(
                  child: Text("No orders yet !"),
                )
              : ListView.builder(
                  itemCount: controller.orderResponse.value.data?.data.length,
                  itemBuilder: (context, index) => OrderTile(
                      data: controller.orderResponse.value.data!.data[index]))),
    );
  }
}

class OrderTile extends StatelessWidget {
  final OrderData data;
  final bool? fromDel;
  const OrderTile({Key? key, required this.data, this.fromDel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductController>();
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15))),
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text("Order Id: "),
                      SizedBox(
                        width: 150,
                        child: Text(
                          data.id ?? "",
                          style: TextStyle(
                            color: Colors.black87,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      )
                    ],
                  ),
                  Text(
                    data.status,
                    style: TextStyle(
                        fontSize: 16,
                        color: data.status == "ORDERED"
                            ? Colors.green
                            : data.status == "FAILED"
                                ? Colors.red
                                : Colors.black87,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.5),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: AppText(
                  text: "Ordered Address",
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AppText(
                    text:
                        "${data.address.name}\n${data.address.address}\n${data.address.type}",
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              SizedBox(
                  child: Wrap(
                children: [
                  Flexible(
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: data.cart.products.length,
                        itemBuilder: (context, index) => ProductOrderTile(
                            product: data.cart.products[index])),
                  ),
                ],
              )),
              Divider(
                color: Colors.green.shade500,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.print,
                        color: AppColors.primaryColor,
                      )),
                  AppText(
                    text:
                        "Grand Total : ${data.cart.total?.toStringAsFixed(2)}",
                    fontWeight: FontWeight.bold,
                    color: Colors.green.shade700,
                  )
                ],
              ),
              fromDel == true
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        data.status == "PENDING"
                            ? controller.orderUpdateResponse.value.status ==
                                    Status.LOADING
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : ElevatedButton(
                                    onPressed: () {
                                      controller.updateOrders(
                                          data.id ?? "", {'status': 'FAILED'});
                                    },
                                    child: Text("Reject"))
                            : SizedBox(),
                        data.status == "PENDING"
                            ? controller.orderUpdateResponse.value.status ==
                                    Status.LOADING
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : ElevatedButton(
                                    onPressed: () {
                                      controller.updateOrders(
                                          data.id ?? "", {'status': 'ORDERED'});
                                    },
                                    child: Text("Accept"))
                            : SizedBox(),
                        data.status == "ORDERED"
                            ? controller.orderUpdateResponse.value.status ==
                                    Status.LOADING
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : ElevatedButton(
                                    onPressed: () {
                                      controller.updateOrders(data.id ?? "",
                                          {'status': 'DELIVERED'});
                                    },
                                    child: Text("Delivered"))
                            : SizedBox(),
                      ],
                    )
                  : SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}

class ProductOrderTile extends StatelessWidget {
  final CartProduct product;
  const ProductOrderTile({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white70,
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 80,
                  height: 80,
                  child: Image.network(
                      "${AppConstants.imagePath}${product.product.thumbnail ?? " "}"),
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      text: product.product.name,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        AppText(
                          text: "Qty",
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        AppText(
                          text: product.quantity.toString(),
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AppText(
                  text: "Sub Total : ${product.price.toStringAsFixed(2)}",
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

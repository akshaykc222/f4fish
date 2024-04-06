import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/common_widgets/app_text.dart';
import 'package:grocery_app/core/response_classify.dart';
import 'package:grocery_app/domain/entity/cart_entity.dart';
import 'package:grocery_app/presentation/controller/cart_controller.dart';

import '../../data/remote/routes.dart';
import 'item_counter_widget.dart';

class ChartItemWidget extends StatefulWidget {
  ChartItemWidget({Key? key, required this.item}) : super(key: key);
  final CartProduct item;

  @override
  _ChartItemWidgetState createState() => _ChartItemWidgetState();
}

class _ChartItemWidgetState extends State<ChartItemWidget> {
  final double height = 160;

  final Color borderColor = Color(0xffE2E2E2);

  final double borderRadius = 18;

  int amount = 1;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CartController>();
    return Container(
      // height: height,
      // width: 350,
      padding: EdgeInsets.all(6),
      margin: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            offset: const Offset(
              10.0,
              1.50,
            ),
            blurRadius: 10.0,
            spreadRadius: 2.0,
          ),
          BoxShadow(
            color: Colors.grey.shade50,
            offset: const Offset(
              5.0,
              .250,
            ),
            blurRadius: 10.0,
            spreadRadius: 1.0,
          ),
          BoxShadow(
            color: Colors.grey.shade200,
            offset: const Offset(
              5.0,
              0.0,
            ),
            blurRadius: 10.0,
            spreadRadius: 2.0,
          ), //BoxShadow
        ],
      ),
      child: Wrap(
        children: [
          SizedBox(
            height: 150,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 120,
                  child: AppText(
                    text: widget.item.product.name,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    textAlign: null,
                  ),
                ),

                ///image
                Center(child: imageWidget()),
              ],
            ),
          ),
          ListView.builder(
              shrinkWrap: true,
              itemCount: widget.item.qtyType.length,
              itemBuilder: (context, index) => Obx(
                  () => controller.addCartResponse.value.status ==
                          Status.LOADING
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Container(
                          height: 50,
                          width: double.infinity,
                          margin:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 120,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppText(
                                      text: widget.item.qtyType[index].variant
                                              .variantName ??
                                          "",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      textAlign: null,
                                    ),
                                    AppText(
                                      text: widget.item.qtyType[index].variant
                                              .sellingPrice
                                              ?.toStringAsFixed(2) ??
                                          "",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      textAlign: null,
                                      color: Colors.green.shade700,
                                    ),
                                  ],
                                ),
                              ),

                              ///image
                              ItemCounterWidgetNew(
                                  onAmountChanged: () {},
                                  incrementFunction: () {
                                    controller.updateCartProduct(
                                        product: widget.item,
                                        increment: true,
                                        qty:
                                            widget.item.qtyType[index].variant);
                                  },
                                  decrementFunction: () {
                                    controller.updateCartProduct(
                                        product: widget.item,
                                        increment: false,
                                        qty:
                                            widget.item.qtyType[index].variant);
                                  },
                                  qty: widget.item.qtyType[index].qty),
                            ],
                          ),
                        )

                  /*ListTile(
                          title: Text(
                              "${widget.item.qtyType[index].variant.variantName ?? ""} * ${widget.item.qtyType[index].qty} : ${(widget.item.qtyType[index].variant.sizeVariant.price ?? 0) * widget.item.qtyType[index].qty}"),
                          subtitle: GestureDetector(
                              onTap: () =>
                                  controller.deleteCart(widget.item.id!),
                              child: removeButton()),
                          trailing: SizedBox(
                            width: 150,
                            height: 50,
                            child: ItemCounterWidgetNew(
                                onAmountChanged: () {},
                                incrementFunction: () {
                                  controller.updateCartProduct(
                                      product: widget.item,
                                      increment: true,
                                      qty: widget.item.qtyType[index].variant);
                                },
                                decrementFunction: () {
                                  controller.updateCartProduct(
                                      product: widget.item,
                                      increment: false,
                                      qty: widget.item.qtyType[index].variant);
                                },
                                qty: widget.item.qtyType[index].qty),
                          ),
                        )*/
                  ))
        ],
      ),
    );
  }

  Widget imageWidget() {
    return widget.item.product.thumbnail?.length == null
        ? Container(
            height: 90,
            width: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              image: DecorationImage(
                  fit: BoxFit.fill, image: AssetImage("assets/icons/logo.png")),
            ),
          )
        : Container(
            height: 90,
            width: 120,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                    "${AppRemoteRoutes.imagUrl}${widget.item.product.thumbnail}",
                  ),
                )));

    /*Container(
      width: 150,
      height: 80,
      decoration: BoxDecoration(

      ),
      child: CachedNetworkImage(
        imageUrl: "${AppRemoteRoutes.baseUrl}${widget.item.product.thumbnail}",
        errorWidget: (c, s, sd) => Image.asset("assets/icons/logo.png"),
      ),
    );*/
  }

  double getPrice() {
    return widget.item.price * amount;
  }
}

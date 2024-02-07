/*import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/app_constants.dart';
import 'package:grocery_app/common_widgets/app_text.dart';
import 'package:grocery_app/domain/entity/ProductEntity.dart';
import 'package:grocery_app/domain/entity/cart_entity.dart';
import 'package:grocery_app/presentation/controller/cart_controller.dart';
import '../../core/response_classify.dart';
import '../../data/remote/routes.dart';
import '../../injecter.dart';
import '../controller/product_controller.dart';
import '../styles/colors.dart';
import 'big_text.dart';
import 'buttons.dart';
import 'item_counter_widget.dart';

class SubItemWidget extends StatefulWidget {
  SubItemWidget({Key? key, required this.item,required this.grocceryItem}) : super(key: key);
  final CartProduct item;
  final QuantityVariant grocceryItem;

  @override
  _ChartItemWidgetState createState() => _ChartItemWidgetState();
}

class _ChartItemWidgetState extends State<SubItemWidget> {
  final double height = 160;

  final Color borderColor = Color(0xffE2E2E2);

  final double borderRadius = 18;

  int amount = 1;

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();

    final controller =
    Get.put(ProductController(sl(), sl(), sl(), sl(), sl(), sl(), sl()));
    return Container(
      height: height,
      width: 350,
      padding: EdgeInsets.all(6),
      margin: EdgeInsets.symmetric(vertical: 5),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10),),
        border: Border.all(
            color: Colors.grey.shade100
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            offset: const Offset(
              10.0,
              1.50,
            ),
            blurRadius: 10.0,
            spreadRadius: 2.0,
          ), BoxShadow(
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 120,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                AppText(
                  text:
                  widget.grocceryItem.variantName.toString(),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  textAlign: TextAlign.right,
                ),

                SizedBox(
                  height: 5,
                ),
                SizedBox(
                  height: 10,
                ),
                AppText(
                  text:widget.grocceryItem.sellingPrice.toString(),
                  color: Colors.green.shade700,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  textAlign: null,
                ),
                SizedBox(
                  height: 12,
                ),



              ],
            ),
          ),

          SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ///image
                Center(child:  Container(
                  height: 90,
                  width: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    image: DecorationImage(
                      fit:BoxFit.fill ,
                      image: NetworkImage(
                          "${AppRemoteRoutes.baseUrl}${widget.groceryItem.thumbnail}"
                      ),
                    ),
                  ),
                )),


                spacer10,
                  ItemCounterWidgetNew(
                    onAmountChanged: () {},
                    incrementFunction: () {
                      cartController.updateCartProduct(
                          product: widget.item, increment: true);
                    },
                    decrementFunction: () {
                      cartController.updateCartProduct(
                          product: widget.item, increment: false);
                    },
                    qty: widget.item.quantity
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget imageWidget() {
    return widget.item.product.thumbnail?.length==null?
    Container(
      height: 90,
      width: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        image: DecorationImage(
            fit:BoxFit.fill ,
            image: AssetImage("assets/icons/logo.png")
        ),
      ),
    ):
    Container(
      height: 90,
      width: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        image: DecorationImage(
          fit:BoxFit.fill ,
          image: NetworkImage(
              "${AppRemoteRoutes.baseUrl}${widget.item.product.thumbnail}"
          ),
        ),
      ),
    );



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
}*/

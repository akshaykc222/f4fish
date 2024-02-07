import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/app_constants.dart';
import 'package:grocery_app/common_widgets/app_text.dart';
import 'package:grocery_app/core/response_classify.dart';
import 'package:grocery_app/domain/entity/ProductEntity.dart';
import 'package:grocery_app/presentation/controller/cart_controller.dart';
import 'package:grocery_app/presentation/controller/product_controller.dart';

import '../../../styles/themes.dart';
import '../../controller/home_controller.dart';
import '../../widgets/big_text.dart';
import '../../widgets/buttons.dart';
import '../../widgets/chart_item_widget.dart';
import '../../widgets/product_container.dart';
import '../../widgets/shimmer_widget.dart';
import '../driver/home.dart';
import '../product_details/product_details_screen.dart';
import 'checkout_bottom_sheet.dart';

class CartScreen extends StatelessWidget {
  final controller = Get.find<CartController>();

  final productcontroller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    final productController = Get.find<ProductController>();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getCart();
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 70,
        leading: backButton(),
        centerTitle: true,
        title: Text(
          "Cart",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        elevation: 0,
      ),
      body: Stack(children: [
        SingleChildScrollView(
          child: Column(children: [
            SizedBox(
              height: 50,
            ),
            Obx(() => controller.getCartResponse.value.status == Status.LOADING
                ? ListView.builder(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (ctx, index) => Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 25,
                          ),
                          width: double.maxFinite,
                          // child: Text(controller.getCartResponse.value
                          //     .data!.data.products[index].product.name),
                          child: ShimmerCart,
                        ),
                    itemCount: 3)
                : controller.getCartResponse.value.status == Status.ERROR
                    ? Center(
                        child: Text(""),
                      )
                    : controller.getCartResponse.value.data?.data.products
                                .isEmpty ==
                            true
                        ? Center(
                            child: AppText(
                              text: "No items to check out",
                            ),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (ctx, index) => Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 25,
                                  ),
                                  width: double.maxFinite,
                                  // child: Text(controller.getCartResponse.value
                                  //     .data!.data.products[index].product.name),
                                  child: GestureDetector(
                                    onTap: () {},
                                    child: ChartItemWidget(
                                      item: controller.getCartResponse.value
                                          .data!.data.products[index],
                                    ),
                                  ),
                                ),
                            itemCount: controller.getCartResponse.value.data
                                    ?.data.products.length ??
                                0)),
            spacer26,
            Obx(() => Container(
                  // height: 250,
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: productcontroller
                              .response.value.data?.products.length ??
                          0,
                      itemBuilder: (context, index) => Container(
                            // height: 250,
                            child: Column(
                              children: [
                                padded(_subTitle(productcontroller.response
                                        .value.data?.products[index].title ??
                                    "")),
                                getHorizontalItemSlider(
                                    productcontroller.response.value.data!
                                        .products[index].data!,
                                    context)
                              ],
                            ),
                          )),
                )),
            spacer30,
            spacer30
          ]),
        ),

        ///  go to check out button
        Positioned(
            bottom: 18,
            left: 10,
            right: 10,
            height: 50,
            // padding: EdgeInsets.only(bottom: 8, left: 25, right: 25),
            // p: Alignment.bottomCenter,
            child: Obx(() => controller.getCartResponse.value.status ==
                    Status.LOADING
                ? Center(
                    child: SizedBox(),
                  )
                : controller.getCartResponse.value.data!.data.products.isEmpty
                    ? Container()
                    : SizedBox(
                        height: 102, child: getCheckoutButton(context)))),
      ]),
    );
  }

  Widget getCheckoutButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showBottomSheet(context);
      },
      child: Container(
          alignment: Alignment.center,
          height: 30,
          decoration: BoxDecoration(
              color: Colors.indigo.shade600,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          padding: EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // total items
              Text(
                controller.getCartResponse.value.data!.data.products.length
                            .toString() +
                        " items" ??
                    " ",
                style: Add,
              ),

              VerticalDivider(
                color: Colors.white,
                indent: 18,
                endIndent: 18,
                thickness: 2,
              ),
              Text(
                controller.getCartResponse.value.data!.data.total.toString(),
                style: Add,
              ),
              //total amount

              spacerW30,
              Text(
                "Go To Checkout",
                style: Add,
              ),
            ],
          )),
    );
  }

  Widget getHorizontalItemSlider(
      List<ProductEntity> items, BuildContext context) {
    return Container(
        padding: EdgeInsets.only(bottom: 30, left: 10),
        height: 320,
        child: ListView.builder(
            itemCount: items.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  onItemClicked(context, items[index]);
                },
                child: popularProductContainer(
                  image:
                      "${AppConstants.imagePath}${items[index].thumbnail ?? " "}",
                  price: items[index].quantityType.first.price!.toDouble(),
                  name: items[index].name,
                  sellingPrice:
                      items[index].quantityType.first.sellingPrice!.toDouble(),
                  quantityType:
                      items[index].quantityType.first.sizeName.toString(),
                ),
              );
              /* GestureDetector(
            onTap: () {
              onItemClicked(context, items[index]);
            },
            child: GroceryItemCardWidget(
              item: items[index],
              heroSuffix: "home_screen",
            ),
          );
        },
      ),
      */
            }));

    /*Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      // height: 250,
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 20),
        itemCount: items.length,
        shrinkWrap: true,
        // scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              onItemClicked(context, items[index]);
            },
            child: GroceryItemCardWidget(
              item: items[index],
              heroSuffix: "home_screen",
            ),
          );
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
            childAspectRatio: 3 / 4),
      ),
    );*/
  }

  void onItemClicked(BuildContext context, ProductEntity groceryItem) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ProductDetailsScreen(
                groceryItem,
                heroSuffix: "home_screen",
              )),
    );
  }

  Widget getButtonPriceWidget() {
    return Container(
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Color(0xff489E67),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        (controller.cartList.value!.data.total ?? 00).toStringAsFixed(2),
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    );
  }

  _subTitle(String text) {
    return Row(
      children: [
        BigText(
          text: text,
          size: 18,
          color: Colors.black87,
        ),
        Spacer(),
      ],
    );
  }

  void showBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext bc) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: CheckoutBottomSheet(),
          );
        });
  }
}

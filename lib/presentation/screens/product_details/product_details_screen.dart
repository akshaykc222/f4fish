import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/common_widgets/app_text.dart';
import 'package:grocery_app/data/remote/routes.dart';
import 'package:grocery_app/domain/entity/ProductEntity.dart';
import 'package:grocery_app/domain/usecase/get_token_usercase.dart';
import 'package:grocery_app/presentation/controller/cart_controller.dart';
import 'package:grocery_app/presentation/controller/product_controller.dart';
import 'package:grocery_app/presentation/routes.dart';
import 'package:grocery_app/presentation/screens/product_details/favourite_toggle_icon_widget.dart';
import 'package:grocery_app/presentation/widgets/big_text.dart';
import 'package:grocery_app/presentation/widgets/item_counter_widget.dart';
import 'package:grocery_app/styles/colors.dart';

import '../../../app_constants.dart';
import '../../../core/response_classify.dart';
import '../../../core/usecase.dart';
import '../../../injecter.dart';
import '../../../styles/themes.dart';
import '../../widgets/buttons.dart';

class ProductDetailsScreen extends StatefulWidget {
  final ProductEntity groceryItem;
  final String heroSuffix;
  const ProductDetailsScreen(this.groceryItem, {required this.heroSuffix});

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen>
    with TickerProviderStateMixin {
  int amount = 1;
  int newAmount = 0;
  final controller =
      Get.put(ProductController(sl(), sl(), sl(), sl(), sl(), sl(), sl()));
  final cartController = Get.put(CartController(sl(), sl(), sl()));
  late Animation _heartAnimation;
  late AnimationController _animationController;

  checkToken() async {
    var token = await GetTokenUserCase(sl()).call(NoParams());
    if (token != "") {
      cartController.getCart();
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getProductExpandDetails(widget.groceryItem.id);
      checkToken();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            extendBodyBehindAppBar: true, // Make the app bar transparent
            appBar: AppBar(
              elevation: 0,
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
              title: backButtonAvatar(),
              actions: [
                Heart(),
                shareButton(),
                cartButton(),
                SizedBox(width: 10)
              ],
            ),
            body: Stack(children: [
              SingleChildScrollView(
                child: DefaultTabController(
                  length: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Image of the product
                      getImageHeaderWidget(widget.groceryItem),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 15),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ///Productname
                              Text(
                                widget.groceryItem.name +
                                    " / " +
                                    widget
                                        .groceryItem.quantityType[0].variantName
                                        .toString(),
                                style: productDetailHeading,
                                maxLines: 3,
                              ),
                              spacer20,
                              Text(
                                widget.groceryItem.quantityType[0].sellingPrice
                                        .toString() +
                                    " / " +
                                    widget.groceryItem.quantityType[0].sizeName
                                        .toString(),
                                style: quantityTypeDetailHeading,
                                textAlign: TextAlign.end,
                              ),

                              /*///size type
                         Text(
                            widget
                               .groceryItem.sizeType.toString(),
                           style: TextStyle(
                             fontSize:24,
                             fontWeight: FontWeight.w300,
                             color: Colors.black,
                           ),
                         ),*/
                              SizedBox(
                                height: 12,
                              ),

                              /// Tab Bar view

                              TabBar(
                                tabs: [
                                  Tab(
                                      child: BigText(
                                    text: "Custamize",
                                    color: Colors.black87,
                                    size: 20,
                                  )),
                                  Tab(
                                      child: BigText(
                                    text: "About",
                                    color: Colors.black87,
                                    size: 20,
                                  )),
                                ],
                              ),

                              SizedBox(
                                height:
                                    widget.groceryItem.quantityType.length < 2
                                        ? 350.0
                                        : widget.groceryItem.quantityType.length
                                                .toDouble() *
                                            220,
                                width: double.infinity,
                                child: TabBarView(
                                    clipBehavior: Clip.none,
                                    physics: NeverScrollableScrollPhysics(),
                                    children: [
                                      ListView.builder(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: widget
                                              .groceryItem.quantityType.length,
                                          itemBuilder: (context, index) {
                                            var item = widget.groceryItem
                                                .quantityType[index];
                                            return ProductSubItems(
                                              item: item,
                                              entity: widget.groceryItem,
                                            );
                                          }),
                                      SizedBox(
                                        height: 400,
                                        child: Obx(
                                          () => controller.expandResponse.value
                                                      .status ==
                                                  Status.LOADING
                                              ? Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                )
                                              : getProductDetails(
                                                  "product details",
                                                  controller
                                                          .expandResponse
                                                          .value
                                                          .data
                                                          ?.description ??
                                                      ""),
                                        ),
                                      ),
                                    ]),
                              ),

                              spacer30,
                            ]),

                        /*SizedBox(
                      height: MediaQuery.of(context).size.height * 0.6,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: ListView(
                          physics: BouncingScrollPhysics(),
                          children: [
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text(
                                widget.groceryItem.name,
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                              subtitle: Row(
                                children: [
                                  AppText(
                                    text: widget
                                        .groceryItem.quantityType.first.price
                                        .toStringAsFixed(2),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff7C7C7C),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      widget.groceryItem.quantityType.first
                                          .sellingPrice
                                          .toStringAsFixed(2),
                                      style: TextStyle(
                                          decoration: TextDecoration.lineThrough),
                                    ),
                                  )
                                ],
                              ),
                              // trailing:
                              //     SizedBox(width: 50, height: 50, child: Heart()),
                            ),
                            // Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ItemCounterWidget(
                                  onAmountChanged: (newAmount) {
                                    controller.changeTotal();
                                  },
                                ),
                                // Spacer(),
                                Obx(() => Text(
                                  controller.totalAmount.toString(),
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ))
                              ],
                            ),
                            // Spacer(),
                            Divider(thickness: 1),
                            getProductDataRowWidget("Product Details",
                                data: Obx(
                                      () => controller.expandResponse.value.status ==
                                      Status.LOADING
                                      ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                      : Column(children: [
                                    Text(controller.expandResponse.value
                                        .data?.description ??
                                        ""),
                                  ]),
                                )),
                            Divider(thickness: 1),
                            getProductDataRowWidget("Quantity",
                                data: Obx(() => Container(
                                    height: 50,
                                    width: MediaQuery.of(context).size.width,
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemCount: controller.expandResponse.value
                                            .data?.quantityType.length,
                                        itemBuilder: (context, index) =>
                                            GestureDetector(
                                              onTap: () {
                                                controller.setQuantity(controller
                                                    .expandResponse
                                                    .value
                                                    .data!
                                                    .quantityType[index]);
                                              },
                                              child: Padding(
                                                padding:
                                                const EdgeInsets.all(8.0),
                                                child: Container(
                                                  // padding: EdgeInsets.only(left: 16),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          8),
                                                      border: Border.all(
                                                          width: 1,
                                                          color: controller
                                                              .selectedQuantity
                                                              .value ==
                                                              controller
                                                                  .expandResponse
                                                                  .value
                                                                  .data!
                                                                  .quantityType[index]
                                                              ? Colors.blueAccent
                                                              : Colors.black54)),
                                                  child: Center(
                                                    child: Padding(
                                                      padding:
                                                      const EdgeInsets.all(
                                                          8.0),
                                                      child: Text(controller
                                                          .expandResponse
                                                          .value
                                                          .data!
                                                          .quantityType[index]
                                                          .variantName),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )))),
                                customWidget: Obx(() => Container(
                                  padding: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                          width: 1,
                                          color: AppColors.primaryColor)),
                                  child: Text(
                                    controller.selectedQuantity.value
                                        ?.variantName ??
                                        "",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ))),
                            // /Divider(thickness: 1),
                            // getProductDataRowWidget("Review",
                            //     customWidget: ratingWidget(), data: Container()),
                            // Spacer(),
                            // Spacer(),
                          ],
                        ),
                      ),
                    ),*/
                      ),
                      spacer30,

                      spacer30
                    ],
                  ),
                ),
                /*bottomNavigationBar:  Container(
            padding: EdgeInsets.only(bottom: 8, left: 25, right: 25),
            child: Obx(() =>
            cartController.addCartResponse.value.status ==
                Status.LOADING
                ? Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryColor,
              ),
            )
                : AppButton(
              label: "Add To Basket",
              onPressed: () {
                debugPrint("--PRESSING--");
                cartController.addCart(
                    widget.groceryItem,
                    controller.selectedQuantity.value!,
                    controller.quantityCount.value);
              },
            ))),*/
                ///bottom navigation bar to show the go to cart button
                /* bottomNavigationBar: cartController.cartList.value?.data.total==null?
        SizedBox(height: 0,):
        GestureDetector(
          onTap: ()=>Get.toNamed(AppRemoteRoutes.cart),
          child: Container(
            height: 70,
            width: 200,
            margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
            color: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Obx(() => BigText(text: cartController.cartList.value!.data.products.length.toString()+" items",
                      color: Colors.green.shade800,
                      size: 15,
                    ),),


                    VerticalDivider(
                      indent: 25,
                      endIndent: 25,
                      thickness: 1,
                      color: Colors.green.shade800,
                    ),
                    BigText(text: " view cart >>",
                    color: Colors.green.shade800,
                      size: 15,
                    ),
                  ],
                ),
                GestureDetector(
                  onTap:()=> Get.toNamed(AppRoutes.cart),
                  child: Container(
                    width: 130,
                    height: 60,
                    margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                      decoration: BoxDecoration(
                        color: Color(0xff489E67),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    child:Center(
                      child:BigText(
                        text: cartController.cartList.value!.data.total.toString(),
                        color: Colors.white,
                        size: 20,
                      )
                    )
                  ),
                )
              ],
            ),
          ),
        )
      */
              ),
              Positioned(
                  bottom: 18,
                  left: 10,
                  right: 10,
                  height: 50,
                  // padding: EdgeInsets.only(bottom: 8, left: 25, right: 25),
                  // p: Alignment.bottomCenter,
                  child: Obx(
                      () => cartController.getCartResponse.value.status ==
                                  Status.LOADING ||
                              cartController.getCartResponse.value.data?.data
                                      .products.isEmpty ==
                                  true
                          ? SizedBox(
                              height: 102,
                            )
                          :
                          //     :cartController.getCartResponse.value.data!.data.products
                          //     .isEmpty
                          //     ? controller.quantityCount>=1?
                          SizedBox(
                              height: 102, child: getCheckoutButton(context))
                      //     : Center(
                      //     child: SizedBox(),
                      // ):Center(
                      //   child: SizedBox(),
                      // )
                      ))
            ])));
  }

  Widget getCheckoutButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.cart);
        //cartController.addCart(widget.groceryItem,
        //     controller.selectedQuantity.value!, controller.quantityCount.value);
      },
      child: Container(
          alignment: Alignment.center,
          height: 30,
          decoration: BoxDecoration(
              color: Colors.green.shade700,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          padding: EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              spacerW10,
              // total items
              Text(
                cartController.getCartResponse.value.data!.data.products.length
                            .toString() +
                        " items" ??
                    " ",
                style: Add,
              ),
              VerticalDivider(
                color: Colors.white70,
                indent: 18,
                endIndent: 18,
                thickness: 2,
              ),
              //total amount
              Text(
                cartController.getCartResponse.value.data?.data.total
                        .toString() ??
                    "",
                style: Add,
              ),
              spacerW30, spacerW30,
              Text(
                "go To Cart",
                style: Add,
              ),
              spacerW10
            ],
          )),
    );
  }

  Widget getCheckoutButtoN() {
    return GestureDetector(
      onTap: () {},
      child: Container(
          alignment: Alignment.center,
          height: 30,
          decoration: BoxDecoration(
              color: AppColor.rose_red.shade700,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          padding: EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // total items
              BigText(
                text: "0 items",
                color: Colors.white,
                size: 15,
              ),
              VerticalDivider(
                color: Colors.white70,
                indent: 18,
                endIndent: 18,
                thickness: 2,
              ),
              //total amount
              BigText(
                text: "0.0",
                color: Colors.white,
                size: 15,
              ),
              spacerW30,
              BigText(
                text: "Go To CART",
                color: Colors.white,
                size: 15,
              ),
            ],
          )),
    );
  }

/*
  Widget getImageHeaderWidget() {
    return Stack(
      children: [
        Container(
          height: 250,
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25),
            ),
            gradient: new LinearGradient(
                colors: [
                  const Color(0xFF3366FF).withOpacity(0.1),
                  const Color(0xFF3366FF).withOpacity(0.09),
                ],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(0.0, 1.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
          child: Hero(
            tag: "GroceryItem:" +
                widget.groceryItem.name +
                "-" +
                (widget.heroSuffix),
            child: Container(
              height: 250,
              child: Stack(
                children: [
                  Obx(() {
                    return controller.expandResponse.value.status ==
                        Status.LOADING
                        ? Center(
                      child: CircularProgressIndicator(),
                    )
                        : Container(
                      height: 250,
                      width: MediaQuery.of(context).size.width,
                      child: CachedNetworkImage(
                        imageUrl: controller.thumbImage.value ?? "",
                        fit: BoxFit.cover,
                        placeholder: (a, b) =>
                            Image.asset("assets/icons/logo.png"),
                        errorWidget: (a, b, c) =>
                            Image.asset("assets/icons/logo.png"),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          height: 50,
          width: MediaQuery.of(context).size.width,
          child: Obx(() => ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 15),
              scrollDirection: Axis.horizontal,
              itemCount:
              controller.expandResponse.value.data?.images?.length ?? 0,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () => controller.changeThumbnail(controller
                    .expandResponse.value.data?.images?[index].image ??
                    ""),
                child: Container(
                    width: 50,
                    height: 50,
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(15)),
                    child: CachedNetworkImage(
                      imageUrl: controller.expandResponse.value.data
                          ?.images?[index].image ??
                          "",
                      placeholder: (context, item) => Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.amberAccent.shade100,
                        ),
                      ),
                    )),
              ))),
        ),
      ],
    );
  }*/

  getImageHeaderWidget(ProductEntity item) {
    return Container(
      height: 250,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(
                "${AppConstants.imagePath}${item.thumbnail ?? " "}",
              ))),
    );
  }

  getProductDetails(String label, String data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 20,
        ),
        BigText(
          text: label,
          color: Colors.black,
          size: 20,
        ),
        SizedBox(
          height: 10,
        ),
        Text(data)
      ],
    );
  }

  Widget getProductDataRowWidget(String label,
      {Widget? customWidget, required Widget data}) {
    return ExpansionTile(
      title: Container(
        margin: EdgeInsets.only(
          top: 20,
          bottom: 20,
        ),
        child: Column(
          children: [
            Row(
              children: [
                AppText(text: label, fontWeight: FontWeight.w600, fontSize: 16),
                Spacer(),
                if (customWidget != null) ...[
                  customWidget,
                  SizedBox(
                    width: 20,
                  )
                ],
                // Icon(
                //   Icons.arrow_forward_ios,
                //   size: 20,
                // )
              ],
            ),
          ],
        ),
      ),
      children: [data],
    );
  }

  /* Widget getProductDataRowWidget(String label,
      {Widget? customWidget, required Widget data}) {
    return ExpansionTile(
      title: Container(
        margin: EdgeInsets.only(
          top: 20,
          bottom: 20,
        ),
        child: Column(
          children: [
            Row(
              children: [
                AppText(text: label, fontWeight: FontWeight.w600, fontSize: 16),
                Spacer(),
                if (customWidget != null) ...[
                  customWidget,
                  SizedBox(
                    width: 20,
                  )
                ],
                // Icon(
                //   Icons.arrow_forward_ios,
                //   size: 20,
                // )
              ],
            ),
          ],
        ),
      ),
      children: [data],
    );
  }*/
}

class ProductSubItems extends StatelessWidget {
  final QuantityVariant item;
  final ProductEntity entity;
  const ProductSubItems({required this.item, required this.entity});

  @override
  Widget build(BuildContext context) {
    final showLoading = ValueNotifier<bool>(false);
    final cartController = Get.find<CartController>();
    return GestureDetector(
        onTap: () {},
        child: Container(
          height: 160,
          width: double.infinity,
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.only(bottom: 15),
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
                  0,
                  5.0,
                ),
                blurRadius: 10.0,
                spreadRadius: 2.0,
              ),
              BoxShadow(
                color: Colors.black.withOpacity(.05),
                offset: const Offset(
                  0,
                  -10.0,
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
                      text: item.variantName!,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      textAlign: null,
                    ),
                    spacer30, spacer20,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "₹" + item.sellingPrice.toString(),
                          style: priceHeading,
                        ),
                        // Text(
                        //  "₹ " + item.sizeVariant!.price.toString(),
                        //  style: sellingPriceHeading,
                        // ),
                      ],
                    ),

                    SizedBox(
                      height: 10,
                    ),

                    ///remove button
                  ],
                ),
              ),
              SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ///image
                    Center(
                        child: Container(
                      height: 80,
                      width: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      child: CachedNetworkImage(
                        fit: BoxFit.fill,
                        errorWidget: (ctx, error, child) =>
                            Image.asset("assets/icons/logo.png"),
                        imageUrl:
                            "${AppRemoteRoutes.imagUrl}${item.variantImage}",
                      ),
                    )),

                    spacer20,
                    // Obx(() =>
                    ValueListenableBuilder(
                        valueListenable: showLoading,
                        builder: (context, data, child) {
                          return Obx(() {
                            var cartItem = cartController.checkCartContains(
                                variant: item, product: entity);
                            print("======CONTAINS cartItem ${cartItem?.qty}");
                            if (cartController.addCartResponse.value.status !=
                                Status.LOADING) {
                              WidgetsBinding.instance
                                  .addPostFrameCallback((timeStamp) {
                                showLoading.value = false;
                              });
                            }
                            return cartController
                                            .addCartResponse.value.status ==
                                        Status.LOADING &&
                                    showLoading.value
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : cartItem == null
                                    ? ItemAddWidget(
                                        onAmountChanged: () {
                                          showLoading.value = true;
                                          cartController.addCart(
                                              entity, item, 1);
                                        },
                                      )
                                    : ItemCounterWidget(
                                        onDecrement: () {
                                          showLoading.value = true;
                                          cartController
                                              .updateCartProductDetail(
                                                  product: entity,
                                                  increment: false,
                                                  qty: item);
                                        },
                                        onIncrement: () {
                                          print("update_Cart");
                                          showLoading.value = true;
                                          cartController
                                              .updateCartProductDetail(
                                                  product: entity,
                                                  increment: true,
                                                  qty: item);
                                        },
                                        onAmountChanged: (newAmount) {
                                          // cartController.updateCartProduct(
                                          //     product: product,
                                          //     increment: increment);
                                        },
                                        quantity: cartItem.qty,
                                      );
                          });
                        })

                    // : ItemAddWidget()
                    // )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

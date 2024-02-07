import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/common_widgets/app_text.dart';
import 'package:grocery_app/core/response_classify.dart';
import 'package:grocery_app/domain/entity/ProductEntity.dart';
import 'package:grocery_app/presentation/controller/home_controller.dart';
import 'package:grocery_app/presentation/controller/product_controller.dart';
import 'package:grocery_app/presentation/routes.dart';
import 'package:pelaicons/pelaicons.dart';

import '../../../app_constants.dart';
import '../../../styles/colors.dart';
import '../../../styles/themes.dart';
import '../../widgets/big_text.dart';
import '../../widgets/product_container.dart';
import '../../widgets/shimmer_widget.dart';
import '../product_details/product_details_screen.dart';
import 'grocery_featured_Item_widget.dart';
import 'home_banner_widget.dart';

class HomeScreen extends StatelessWidget {
  final controller = Get.find<HomeController>();
  final productController = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
            constraints: BoxConstraints(maxWidth: 500),
            child: Obx(() => controller.response.value.status == Status.ERROR
                ? SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ListView(
                      children: [
                        // SizedBox(
                        //   height: 15,
                        // ),
                        // Image.asset("assets/icons/logo.png"),
                        // SizedBox(
                        //   height: 5,
                        // ),
                        padded(_locationWidget(context)),
                        Spacer(),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/images/error.png",
                              width: 150,
                              height: 150,
                            ),
                            AppText(
                              text: "error",
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            )
                          ],
                        ),
                        Spacer(),
                      ],
                    ),
                  )
                : controller.response.value.status == Status.LOADING
                    ? SingleChildScrollView(
                        child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: ShimmerHome),
                      )

                    /// APP home UI
                    : controller.response.value.status == Status.COMPLETED
                        ? CustomScrollView(
                            slivers: [
                              ///APP bar
                              SliverAppBar(
                                automaticallyImplyLeading: false,
                                floating: true,
                                pinned: true,
                                snap: false,
                                centerTitle: false,
                                expandedHeight: 130,
                                backgroundColor: AppColor.primary,
                                title: _locationWidget(context),
                                actions: [
                                  IconButton(
                                    onPressed: () =>
                                        Get.toNamed(AppRoutes.cart),
                                    icon: Icon(
                                      Pelaicons.cart_2_light_outline,
                                      size: 27,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  IconButton(
                                    onPressed: () =>
                                        Get.toNamed(AppRoutes.account),
                                    icon: Icon(
                                      Pelaicons.user_light_outline,
                                      size: 27,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                ],
                                bottom: AppBar(
                                  automaticallyImplyLeading: false,
                                  backgroundColor: AppColor.primary,
                                  title: Container(
                                    width: double.infinity,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      color: Colors.white,
                                    ),
                                    child: Center(
                                      child: GestureDetector(
                                        onTap: () =>
                                            Get.toNamed(AppRoutes.products),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8)),
                                            color: Colors.white,
                                          ),
                                          width: double.infinity,
                                          height: 40,
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                child: Icon(
                                                  Icons.search_sharp,
                                                  color: Colors.black38,
                                                ),
                                              ),
                                              VerticalDivider(
                                                  indent: 4, endIndent: 4),
                                              Text(
                                                "  search...",
                                                style: lightFont,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              ///////////////////////
                              // padding
                              SliverPadding(padding: EdgeInsets.all(10)),
                              ////////////////////////
                              /// carosel slider ad banner
                              SliverToBoxAdapter(child: HomeBanner()),

                              ///recommended product
                              SliverToBoxAdapter(
                                  child: Obx(() => Container(
                                        // height: 250,
                                        child: ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            itemCount: controller.response.value
                                                .data?.products.length,
                                            itemBuilder: (context, index) =>
                                                Container(
                                                  // height: 250,
                                                  child: Column(
                                                    children: [
                                                      padded(_subTitle(
                                                          controller
                                                                  .response
                                                                  .value
                                                                  .data
                                                                  ?.products[
                                                                      index]
                                                                  .title ??
                                                              "")),
                                                      getHorizontalItemSlider(
                                                          controller
                                                              .response
                                                              .value
                                                              .data!
                                                              .products[index]
                                                              .data!,
                                                          context)
                                                    ],
                                                  ),
                                                )),
                                      ))),
                              /*
                ///////////////////////
                /// popular product
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      seeAllContainer(
                        heading: "Popular Products", isMore: false,),
                      Container(
                        padding: EdgeInsets.only(bottom: 30, left: 10),
                        height: 330,
                        child: ListView(
                          // This next line does the trick.
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            popularProduct(image: "grouper_medium_3.webp"),
                            popularProduct(image: "seer_fish_whole_1_1.jpg"),
                            popularProduct(image: "red-snapper_big.jpg"),
                            popularProduct(image: "seer-steaks-large_02_3.webp"),
                            popularProduct(image: "tuna_whole_3.webp"),
                          ],
                        ),
                        /*
                      * */
                      ),
                    ],
                  ),),
                //////////////////////
                ///catogory from server
                SliverToBoxAdapter(
                  child: ExploreContainer(
                    heading: "WHAT'S IN YOR MIND?",),
                ),*/
                              SliverToBoxAdapter(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  height: 50,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    child: BigText(
                                      text: 'Category',
                                      color: Colors.black,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ),

                              //////////////////////
                              ///GRID VIEW of catogory
                              SliverGrid(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3, //no of row
                                  mainAxisSpacing: 0,
                                  crossAxisSpacing: 0,
                                  childAspectRatio: .90,
                                ),
                                delegate: SliverChildBuilderDelegate(
                                  (context, index) {
                                    return GroceryFeaturedCard(
                                      groceryFeaturedItem: controller
                                          .response.value.data!.category[index],
                                      color: AppColor.orange,
                                      function: () {
                                        productController.getAllProducts(
                                          category: controller.response.value
                                              .data!.category[index].id,
                                        );
                                        Get.toNamed(AppRoutes.products);
                                      },
                                    );
                                  },
                                  childCount: controller
                                      .response.value.data?.category.length,
                                ),
                              ),

                              ///padding
                              SliverPadding(padding: EdgeInsets.all(10)),

                              ///suscribtion
                              /*  SliverToBoxAdapter(
                child: Container(
                  height: 250,
                  color: AppColor.seaformGreen.shade400,
                  child:  Column(
                    children: [
                      SizedBox(height: 20,),
                      Center(child: Text("suscribtion")),
                      SizedBox(height: 70,),
                      CarouselSlider(
                        options: CarouselOptions(
                          height: 100.0,
                          enlargeCenterPage: false,
                          autoPlay: true,
                          aspectRatio: 16 / 9,
                          autoPlayCurve: Curves.fastEaseInToSlowEaseOut,
                          enableInfiniteScroll: true,
                          autoPlayAnimationDuration: Duration(milliseconds: 300),
                          viewportFraction: .5),

                          items: [
                            //3rd Image of Slider
                            Container(
                              margin: EdgeInsets.all(15.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: Colors.indigo,
                              ),
                              child: Image.asset("assets/AD Banners/ADBar 1.webp",
                                fit: BoxFit.fill,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(15.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: Colors.amberAccent,
                              ),
                              child: Image.asset("assets/AD Banners/ADBar 3.webp",
                                fit: BoxFit.fill,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(15.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: Colors.red,
                              ),
                              child: Image.asset("assets/AD Banners/ADBar 4.webp",
                                fit: BoxFit.fill,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(15.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Image.asset("assets/AD Banners/ADBar 1.webp",
                                fit: BoxFit.fill,
                              ),),
                            Container(
                              margin: EdgeInsets.all(15.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Image.asset("assets/AD Banners/ADBar 1.webp",
                                fit: BoxFit.fill,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(15.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Image.asset("assets/AD Banners/AdBar 2.gif",
                                fit: BoxFit.fill,
                              ),
                            ),
                          ],

                          ),
                    ],
                  ),

                  ),
                  ),*/
                              //////////////////////
                              ///casual ending text
                              SliverToBoxAdapter(
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  height: 300,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Live",
                                        style: LIVEITUPFont,
                                      ),
                                      Text(
                                        "it up",
                                        style: LIVEITUPFont,
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            "Crafted with ",
                                            style: LIVEITUPsmallFont,
                                          ),
                                          Icon(
                                            Icons.heart_broken_rounded,
                                            color: roseRedColor,
                                          ),
                                          Text(
                                            " in kozhikode ,india",
                                            style: LIVEITUPsmallFont,
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          )

                        ///
                        /*SingleChildScrollView(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              // SizedBox(
                              //   height: 15,
                              // ),
                              // SvgPicture.asset("assets/icons/app_icon_color.svg"),
                              padded(_locationWidget(context)),
                              SizedBox(
                                height: 15,
                              ),
                              padded(SearchBarWidget()),
                              padded(_subTitle("Categories")),
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                height: 105,
                                child: Obx(
                                  () => controller.response.value.status ==
                                          Status.LOADING
                                      ? Container()
                                      : controller.response.value.status ==
                                              Status.COMPLETED
                                          ? GridView.builder(
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 20),
                                              itemCount: controller.response.value
                                                  .data?.category.length,
                                              itemBuilder: (context, index) {
                                                return GroceryFeaturedCard(
                                                  groceryFeaturedItem: controller
                                                      .response
                                                      .value
                                                      .data!
                                                      .category[index],
                                                  color: tileColors[Random()
                                                      .nextInt(
                                                          tileColors.length)],
                                                  function: () {
                                                    productController
                                                        .getAllProducts(
                                                      category: controller
                                                          .response
                                                          .value
                                                          .data!
                                                          .category[index]
                                                          .id,
                                                    );
                                                    Get.toNamed(
                                                        AppRoutes.products);
                                                  },
                                                );
                                              },
                                              gridDelegate:
                                                  SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 3,
                                                      mainAxisSpacing: 5,
                                                      crossAxisSpacing: 5,
                                                      childAspectRatio:
                                                          150 / 120),
                                            )
                                          : Center(
                                              child: AppText(
                                                text: controller
                                                    .response.value.error
                                                    .toString(),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                              ),
                                            ),
                                ),
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              controller.response.value.data?.offers.isEmpty ==
                                      true
                                  ? SizedBox()
                                  : padded(HomeBanner()),
                              SizedBox(
                                height: 25,
                              ),
                              Obx(() => controller.response.value.status ==
                                      Status.LOADING
                                  ? Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : Container(
                                      // height: 250,
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          physics: NeverScrollableScrollPhysics(),
                                          itemCount: controller.response.value
                                              .data?.products.length,
                                          itemBuilder: (context, index) =>
                                              Container(
                                                // height: 250,
                                                child: Column(
                                                  children: [
                                                    padded(_subTitle(controller
                                                            .response
                                                            .value
                                                            .data
                                                            ?.products[index]
                                                            .title ??
                                                        "")),
                                                    getHorizontalItemSlider(
                                                        controller
                                                            .response
                                                            .value
                                                            .data!
                                                            .products[index]
                                                            .data!,
                                                        context)
                                                  ],
                                                ),
                                              )),
                                    ))
                            ],
                          ),
                        ),
                      )*/
                        ///
                        : Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 60,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.grey.shade300,
                                      radius: 20,
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          color: Colors.grey.shade300,
                                          height: 30,
                                          width: 150,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          color: Colors.grey.shade300,
                                          height: 20,
                                          width: 120,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                Container(
                                  color: Colors.grey.shade300,
                                  width: 300,
                                  height: 40,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Divider(),
                                SizedBox(
                                  height: 40,
                                ),
                                Container(
                                  color: Colors.grey.shade300,
                                  width: 250,
                                  height: 150,
                                ),
                                SizedBox(
                                  height: 50,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      color: Colors.grey.shade300,
                                      height: 200,
                                      width: 150,
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Container(
                                      color: Colors.grey.shade300,
                                      height: 200,
                                      width: 150,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  color: Colors.grey.shade300,
                                  height: 100,
                                ),
                              ],
                            ),
                          ))));
  }

  Widget padded(Widget widget) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: widget,
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
                      items[index].quantityType.first.variantName.toString(),
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

  _subTitle(String text) {
    return Row(
      children: [
        BigText(
          text: text,
          size: 18,
          color: Colors.black87,
        ),
        Spacer(),
        BigText(
          text: "See All",
          size: 15,
          color: Colors.deepPurple,
        ),
      ],
    );
  }

  _locationWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: 8,
        ),
        Icon(
          Icons.location_pin,
          size: 27,
        ),

        Obx(() => controller.location.value == null
            ? TextButton(
                onPressed: () {
                  Get.toNamed(AppRoutes.location);
                },
                child: Text("location"))
            : TextButton(
                onPressed: () {
                  Get.toNamed(AppRoutes.location);
                },
                child: BigText(
                  text: controller.location.value?.name ?? "",
                  size: 16,
                  color: Colors.white,
                ))),
        // Icon(Icons.edit)
      ],
    );
  }
}

/*class HomeProducts extends StatelessWidget {
  final Products homeProducts;
  const HomeProducts({Key? key, required this.homeProducts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}*/

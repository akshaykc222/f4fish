import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/common_widgets/app_text.dart';
import 'package:grocery_app/core/response_classify.dart';
import 'package:grocery_app/presentation/controller/product_controller.dart';
import 'package:grocery_app/presentation/screens/product_details/product_detail-new.dart';
import 'package:grocery_app/presentation/screens/product_details/product_details_screen.dart';
import 'package:grocery_app/presentation/styles/colors.dart';
import '../../../domain/entity/ProductEntity.dart';
import '../../../styles/colors.dart';
import '../../widgets/big_text.dart';
import '../../widgets/buttons.dart';
import '../../widgets/grocery_item_card_widget.dart';
import '../../widgets/shimmer_widget.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductController>();
    void onItemClicked(BuildContext context, ProductEntity groceryItem) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ProductDetailsScreen(
                  groceryItem,
                  heroSuffix: "home_screen",
           )
        ),
      );
    }

    return Scaffold(
      /*
      appBar: AppBar(
        title: SearchBar(),
        backgroundColor: AppColors.primaryColor,
      ),
      */
      appBar: AppBar(
        leading:  backButton(),
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 80.0),
          child: BigText( text: 'Search',size: 20,color: Colors.black,),
        ),
        backgroundColor: Colors.white,
        elevation: 0.3,
        bottom:PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: SearchBarItem()
        ),
      ),
      body: Obx(() => controller.productsAllResponse.value.status ==
              Status.LOADING
          ?  Column(
            children: [
              Expanded(
        child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: GridView.builder(
                  itemCount: 4,
                  gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 2,
                      crossAxisSpacing: 2,
                      childAspectRatio: 8/12),
                  itemBuilder: (context, index) =>
                  ShimmerSearch
              ),
        ),
      ),
            ],
          )
          : controller.productsAllResponse.value.status == Status.ERROR
              ? Center(
                  child: AppText(
                    text: controller.productsAllResponse.value.error.toString(),
                  ),
                )
              : controller.productsAllResponse.value.data!.isEmpty
                  ? Center(
                      child: AppText(text: "No Products Found"),
                    )
                  : Column(
                      children: [
                        SizedBox(height: 30,),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: GridView.builder(
                                itemCount: controller
                                    .productsAllResponse.value.data?.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 2,
                                        crossAxisSpacing: 2,
                                        childAspectRatio: 8/12),
                                itemBuilder: (context, index) => GestureDetector(
                                      onTap: () {
                                        onItemClicked(
                                            context,
                                            controller.productsAllResponse.value
                                                .data![index]);
                                      },
                                      // child: Container()
                                      child: GroceryItemCardWidget(
                                        item: controller.productsAllResponse.value
                                            .data![index],
                                        heroSuffix: "home_screen",
                                        quantityType: controller.productsAllResponse.value
                                            .data![index].quantityType.first.variantName.toString(),
                                      ),
                                    )),
                          ),
                        )
                      ],
                    )),
    );
  }
}
_SearchBarItem ( controller){
  return Container(
    width: 300,
    height: 50,
    margin:EdgeInsets.symmetric(vertical: 10,horizontal: 20),
    child:  Center(
      child: TextFormField(
        cursorHeight:20,
        textInputAction: TextInputAction.search,
        onFieldSubmitted: (val) {
          controller.getAllProducts(search: val);
        },

        decoration: InputDecoration(
          hintText: "Search",
          hintStyle:TextStyle(
            fontSize: 20
          ) ,
          // Add a clear button to the search bar
          //suffixIcon: Icon(Icons.clear),
          // Add a search icon or button to the search bar
          prefixIcon: IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Perform the search here
            },
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),),
  );
}

class SearchBarItem extends StatelessWidget {
  const SearchBarItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductController>();
    return Container(
      width:320,
      height: 45,
      margin: EdgeInsets.symmetric(horizontal: 10,vertical: 7),
      child: TextFormField(
        cursorHeight: 15,
        textInputAction: TextInputAction.search,
        onFieldSubmitted: (val) {
          controller.getAllProducts(search: val);
        },
        style: TextStyle(color: Colors.black38),
        decoration: InputDecoration(
            label: Text("Search",
            ),
            labelStyle: TextStyle(color: Colors.black38),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Colors.grey.shade500,
                )),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
                borderSide: BorderSide(
                  color: Colors.grey.shade400,
                )),
            suffixIcon: Icon(
              Icons.search,
              color: Colors.black38,
            ),
            hintText: "Search",
            hintStyle: TextStyle(color: Colors.grey.shade700),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
      ),
    );
  }
}

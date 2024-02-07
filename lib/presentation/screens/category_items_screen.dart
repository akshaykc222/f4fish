import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:grocery_app/common_widgets/app_text.dart';
import 'package:grocery_app/domain/entity/ProductEntity.dart';
import 'package:grocery_app/presentation/screens/product_details/product_detail-new.dart';
import 'package:grocery_app/presentation/screens/product_details/product_details_screen.dart';

import 'filter_screen.dart';

class CategoryItemsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            padding: EdgeInsets.only(left: 25),
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FilterScreen()),
              );
            },
            child: Container(
              padding: EdgeInsets.only(right: 25),
              child: Icon(
                Icons.sort,
                color: Colors.black,
              ),
            ),
          ),
        ],
        title: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 25,
          ),
          child: AppText(
            text: "Beverages",
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: StaggeredGrid.count(
        crossAxisCount: 4,
        // I only need two card horizontally
        // children: beverages.asMap().entries.map<Widget>((e) {
        //   GroceryItem groceryItem = e.value;
        //   return GestureDetector(
        //     onTap: () {
        //       onItemClicked(context, groceryItem);
        //     },
        //     child: Container(
        //       padding: EdgeInsets.all(10),
        //       child: GroceryItemCardWidget(
        //         item: groceryItem,
        //         heroSuffix: "explore_screen",
        //       ),
        //     ),
        //   );
        // }).toList(),
        // :
        //     beverages.map<StaggeredGridTile>((_) => StaggeredGridTile.fit( crossAxisCellCount: 2, child: _,)).toList(),
        mainAxisSpacing: 3.0,
        crossAxisSpacing: 0.0, // add some space
      ),
    );
  }

  void onItemClicked(BuildContext context, ProductEntity groceryItem) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailsScreen(
          groceryItem,
          heroSuffix: "explore_screen",
        ),
      ),
    );
  }
}

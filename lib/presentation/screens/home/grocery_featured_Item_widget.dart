import 'package:flutter/material.dart';
import 'package:grocery_app/common_widgets/app_text.dart';
import 'package:grocery_app/data/remote/routes.dart';
import 'package:grocery_app/domain/entity/category_entity.dart';

import '../../styles/colors.dart';

class GroceryFeaturedItem {
  final String name;
  final String imagePath;

  GroceryFeaturedItem(this.name, this.imagePath);
}

var tileColors = [
  Color(0xFFACDDDE),
  Color(0xFFCAF1DE),
  Color(0xFFE1F8DC),
  Color(0xFFFEF8DD),
  Color(0xFFFFE7C7),
  Color(0xFFF7D8BA),
];

class GroceryFeaturedCard extends StatelessWidget {
  const GroceryFeaturedCard(
      {this.color = AppColors.primaryColor,
      required this.groceryFeaturedItem,
      required this.function,
      this.image});

  final Category groceryFeaturedItem;
  final Color color;
  final Function function;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => function(),
      child: Container(
        width: 80,
        height: 55,
        margin: EdgeInsets.all(0),
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 0),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          children: [
            Expanded(
                child: Image.network(
                    "${AppRemoteRoutes.imagUrl}${groceryFeaturedItem.image}")),
            SizedBox(
              height: 15,
            ),
            AppText(
              text: groceryFeaturedItem.name,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}

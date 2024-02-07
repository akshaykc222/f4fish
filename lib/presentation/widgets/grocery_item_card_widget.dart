import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/app_constants.dart';
import 'package:grocery_app/domain/entity/ProductEntity.dart';

import '../../styles/themes.dart';
import '../styles/colors.dart';
import 'buttons.dart';

class GroceryItemCardWidget extends StatelessWidget {
  GroceryItemCardWidget(
      {Key? key,
      required this.item,
      required this.quantityType,
      required this.heroSuffix})
      : super(key: key);
  final ProductEntity item;
  final String heroSuffix;
  final Color borderColor = Color(0xffE2E2E2);
  final double borderRadius = 18;
  String quantityType;

  @override
  Widget build(BuildContext context) {
    return popularProductContainer();
  }

  popularProductContainer() {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.white10,
            offset: const Offset(
              10.0,
              1.50,
            ),
            blurRadius: 10.0,
            spreadRadius: 2.0,
          ),
          BoxShadow(
            color: Colors.grey.shade200,
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
              -5.0,
              0.0,
            ),
            blurRadius: 10.0,
            spreadRadius: 2.0,
          ), //BoxShadow
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                      "${AppConstants.imagePath}${item.thumbnail ?? " "}",
                    ))),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 8,
                ),
                Text(
                  quantityType,
                  style: quantityTypeHeading,
                  textAlign: TextAlign.end,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  item.name,
                  style: productCategoryHeading,
                  maxLines: 2,
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "₹" +
                              item.quantityType.first.price!.toStringAsFixed(2),
                          style: priceHeading,
                        ),
                        Text(
                          "₹ " +
                              item.quantityType.first.price!.toStringAsFixed(2),
                          style: sellingPriceHeading,
                        ),
                      ],
                    ),
                    selectProductButton
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget imageWidget(String url) {
    return Container(
      child: CachedNetworkImage(
        imageUrl: url,
        errorWidget: (a, b, c) => Image.asset("assets/icons/logo.png"),
        placeholder: (
          a,
          b,
        ) =>
            Image.asset("assets/icons/logo.png"),
        width: 150,
        height: 150,
      ),
    );
  }

  Widget addWidget() {
    return Container(
      height: 45,
      width: 45,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17),
          color: AppColors.primaryColor),
      child: Center(
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 25,
        ),
      ),
    );
  }
}

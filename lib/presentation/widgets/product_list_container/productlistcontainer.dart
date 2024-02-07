import 'package:flutter/material.dart';

import '../../../styles/themes.dart';
import '../buttons.dart';

class popularProductContainer extends StatelessWidget {
  String image;
  String name;
  int price;

  popularProductContainer({required this.image,
    required this.price, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      width: 200,
      height: 220,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.black12,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.white10,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 130,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)
                ),
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                        image
                    )
                )
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("500g", style: ProductgramFont,),

                SizedBox(height: 10,),
                Text(name, style: ProductHeadingFont,),
                SizedBox(height: 20,),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("\$" + price.toString(), style: ProductPriceFont,),
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
}
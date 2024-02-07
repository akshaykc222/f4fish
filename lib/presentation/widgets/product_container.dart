
import 'package:flutter/material.dart';
import 'package:grocery_app/app_constants.dart';

import '../../styles/themes.dart';
import 'buttons.dart';


class popularProductContainer extends StatelessWidget {
  String image;
  String name;
  String quantityType;
  double price;
  double sellingPrice;
  popularProductContainer({required this.image,required this.sellingPrice,
    required this.price,required this.name,required this.quantityType});

  @override
  Widget build(BuildContext context) {

    return  Container(
      margin: EdgeInsets.all(10),
      width:200,
      height: 220,
      decoration: BoxDecoration(
        color:Colors.white,
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
          ),BoxShadow(
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
                    fit:BoxFit.fill ,
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
                spacer10,
                Text(quantityType,style: quantityTypeHeading,textAlign: TextAlign.end,),

                SizedBox(height: 10,),
                Text(name,style: productHeading,maxLines: 2,softWrap: false),
                spacer30,
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment:CrossAxisAlignment.start,
                      children: [
                        Text("₹"+price.toString(),style: priceHeading,),
                        Text("₹ "+sellingPrice.toString(),style: sellingPriceHeading,),
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
}

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../app_constants.dart';



class Shimmerwidget extends StatelessWidget {

  double width;
  double height;
  double Hpadding;
  double Vpadding;
  double topleft;
  double bottomright;
  double topright;
  double bottomleft;

   Shimmerwidget.rectangular({
    this.width=double.infinity,
     this.bottomright=10,
     this.bottomleft=10,
     this.topleft=10,
     this.topright=10,
    required this.height,
     this.Hpadding= 5.0,
     this.Vpadding= 5.0
});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      period: Duration(milliseconds: 1000),
      baseColor: Colors.black12,
      highlightColor: Colors.white24,
      child: Container(
        width: width,
        height: height,
        margin:EdgeInsets.symmetric(
            horizontal: Hpadding,vertical: Vpadding
        ),
        decoration:BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(topright),
              bottomLeft: Radius.circular(bottomleft),
              topLeft: Radius.circular(topleft),
              bottomRight: Radius.circular(bottomright)
          )
        ),
      ),
    );
  }
}
///shimmer effect in cart screen
Widget get ShimmerCart{
  return  Container(
    height: 160,
    width: 310,
    margin: EdgeInsets.symmetric(vertical: 10),
    decoration: BoxDecoration(
      color: Colors.grey.shade200,
          borderRadius: BorderRadius.all(Radius.circular(10))
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,

          children: [

            Shimmerwidget.rectangular(height: 20,width: 60,),
            Shimmerwidget.rectangular(height: 20,width: 120,),
            Shimmerwidget.rectangular(height: 20,width: 120,),
            Shimmerwidget.rectangular(height: 20,width: 60,),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Shimmerwidget.rectangular(height: 80,width: 120,),
            Shimmerwidget.rectangular(height: 30,width: 120,),
          ],
        )
      ],
    ),
  );
}
///shimmer effect in search screen
Widget get ShimmerSearch{
  return  Container(
    height: 220,
    width: 150,
    margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
    decoration: BoxDecoration(
      color: Colors.grey.shade200,
          borderRadius: BorderRadius.all(Radius.circular(10))
    ),
    child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: [

            Shimmerwidget.rectangular(height: 100,width: 155,Vpadding: 0,Hpadding: 0,bottomleft: 0,bottomright: 0,),
            Shimmerwidget.rectangular(height: 10,width: 30,Vpadding: 3,Hpadding: 10,),
            Shimmerwidget.rectangular(height: 20,width: 120,Vpadding: 10,Hpadding: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Shimmerwidget.rectangular(height: 20,width: 50,Vpadding: 5,Hpadding: 8,),
                Shimmerwidget.rectangular(height: 20,width: 60,Vpadding: 5,Hpadding: 8,)
                    ]),
            spacer30
      ],
    ),
  );
}

Widget get ShimmerHome{
  return  Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      spacer30,spacer30,
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Shimmerwidget.rectangular(height: 30,width: 30,),
          Shimmerwidget.rectangular(height: 30,width: 120,),
          spacerW30,spacerW30,
          Shimmerwidget.rectangular(height: 30,width: 30,),
          Shimmerwidget.rectangular(height: 30,width: 30,),

        ],
      ),
      spacer20,
      spacer20,
      spacer20,
      Shimmerwidget.rectangular(height: 40,width: 300,),


      spacer20,
      Divider(),
      spacer20,spacer20,
      Shimmerwidget.rectangular(height: 150,width: 250,),


      spacer20,spacer30,
      Row(
        children: [
          Shimmerwidget.rectangular(height: 230,width: 150,),
          spacerW5,
          Shimmerwidget.rectangular(height: 230,width: 140,),

        ],
      ),
      SizedBox(height: 20,),
      Shimmerwidget.rectangular(height: 100,),


      spacer30,spacer30

    ],
  );
}
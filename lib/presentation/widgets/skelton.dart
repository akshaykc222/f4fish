import 'package:flutter/material.dart';


Widget get CartSkelton{
  return Row(
 children:
 [
   Skelton(width: 100, color: null, height: 100)
 ]

  );
}



class Skelton extends StatelessWidget {

  double height;
  double width;
  Color? color;

   Skelton({Key? key,required this.width,required this.color,required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: height,
      width: width,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color:color==null? Colors.black.withOpacity(.04):color,
        borderRadius: BorderRadius.all(Radius.circular(10))
      ),
    );
  }
}

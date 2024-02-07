import 'package:flutter/material.dart';

class BigText extends StatelessWidget {

  Color? color;
  final String text;
  double? size ;
  TextOverflow overFlow;
  BigText({Key? key,this.color = const Color(0xFF89dad0),
    required this.text,
    this.overFlow = TextOverflow.ellipsis,
    this.size=40}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overFlow,
      style: TextStyle(
          color: color,
          fontWeight: FontWeight.w400,
          fontSize: size
      ),

    );
  }
}

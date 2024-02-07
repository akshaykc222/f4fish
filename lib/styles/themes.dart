import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';

/// product ending
TextStyle get productHeading {
  return GoogleFonts.josefinSans(
      textStyle: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.bold,
          color:Colors.black87,
        overflow: TextOverflow.ellipsis,

      )
  );
}
///product catogory heading
TextStyle get productCategoryHeading {
  return GoogleFonts.josefinSans(
      textStyle: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color:Colors.black87,
        overflow: TextOverflow.ellipsis,

      )
  );
}
/// product Detail heading
TextStyle get productDetailHeading {
  return GoogleFonts.josefinSans(
      textStyle: TextStyle(
          fontSize: 19,
          fontWeight: FontWeight.bold,
          color:Colors.black87,
        overflow: TextOverflow.ellipsis,

      )
  );
}
///quantity type
TextStyle get quantityTypeHeading {
  return GoogleFonts.arvo(
      textStyle: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color:Colors.black38,
        overflow: TextOverflow.ellipsis,

      )
  );
}

TextStyle get quantityTypeDetailHeading {
  return GoogleFonts.josefinSans(
      textStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color:Colors.black54,
        overflow: TextOverflow.ellipsis,

      )
  );
}

TextStyle get priceHeading {
  return GoogleFonts.roboto(
      textStyle: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
          color:Colors.green.shade700,
        overflow: TextOverflow.ellipsis,

      )
  );
}


TextStyle get Add {
  return GoogleFonts.roboto(
      textStyle: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
          color:Colors.white,
        overflow: TextOverflow.ellipsis,

      )
  );
}

TextStyle get sellingPriceHeading {
  return GoogleFonts.roboto(
      textStyle: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color:Colors.green.shade700,
        overflow: TextOverflow.ellipsis,
          decoration: TextDecoration.lineThrough

      )
  );
}
TextStyle get f4fishHeading{
  return GoogleFonts.cantataOne(
      textStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color:Colors.white
      )
  );
}

TextStyle get buttonHeading{
  return GoogleFonts.cantataOne(
      textStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color:AppColor.whiteBackground
      )
  );
}
TextStyle get buttonBlackHeading{
  return GoogleFonts.cantataOne(
      textStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color:Colors.black54
      )
  );
}TextStyle get ADDHeading{
  return GoogleFonts.cantataOne(
      textStyle: TextStyle(

          fontWeight: FontWeight.bold,
          color:Colors.black38
      )
  );
}
TextStyle get profilebuttonHeading{
  return GoogleFonts.cantataOne(
      textStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color:indigoColor
      )
  );
}
TextStyle get subHeading{
  return GoogleFonts.cantataOne(
      textStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color:Colors.black54
      )
  );
}
TextStyle get mainHeading{
  return GoogleFonts.alice(
      textStyle: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color:Colors.black
      )
  );
}
TextStyle get profileHeading{
  return GoogleFonts.alice(
      textStyle: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w300,
          color:Colors.black
      )
  );
}
TextStyle get buttonfont{
  return GoogleFonts.merriweather(
      textStyle: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color:AppColor.rose_red.shade500
      )
  );
}
TextStyle get containerFont{
  return GoogleFonts.alice(
      textStyle: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: Colors.black
      )
  );
}
TextStyle get priceFont{
  return GoogleFonts.cantataOne(
      textStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.normal,
          color: Colors.black
      )
  );}
TextStyle get lightFont{
  return GoogleFonts.cantataOne(
      textStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: Colors.black38
      )
  );}

TextStyle get moreFont {
  return GoogleFonts.cantataOne(
      textStyle: TextStyle(
          fontSize:15 ,
          fontWeight: FontWeight.normal,
          color: Colors.black54
      )
  );
}

TextStyle get locationMainFont {
  return GoogleFonts.cantataOne(
      textStyle: TextStyle(
          fontSize:14 ,
          fontWeight: FontWeight.bold,
          color: Colors.white
      )
  );
}

TextStyle get locationSubFont {
  return GoogleFonts.cantataOne(
      textStyle: TextStyle(
          fontSize:10 ,
          fontWeight: FontWeight.normal,
          color: Colors.white
      )
  );
}
TextStyle get LIVEITUPFont {
  return GoogleFonts.cantataOne(
      textStyle: TextStyle(
          fontSize:40 ,
          fontWeight: FontWeight.bold,
          color: Colors.black54
      )
  );
}TextStyle get SelectButton {
  return GoogleFonts.alice(
      textStyle: TextStyle(
          fontSize:12 ,
          fontWeight: FontWeight.bold,
          color: Colors.green.shade800
      )
  );
}
TextStyle get LIVEITUPsmallFont {
  return GoogleFonts.cantataOne(
      textStyle: TextStyle(
          fontSize:14,
          fontWeight: FontWeight.bold,
          color: Colors.black54
      )
  );
}
TextStyle get ProductHeadingFont {
  return GoogleFonts.alice(
      textStyle: TextStyle(
          fontSize:17,
          fontWeight: FontWeight.bold,
          color: Colors.black87
      )
  );
}TextStyle get PriceCutHeadingFont {
  return GoogleFonts.alice(
      textStyle: TextStyle(
          fontSize:15,
          fontWeight: FontWeight.normal,
          color: Colors.black54,
        decoration:  TextDecoration.lineThrough
      )
  );
}
TextStyle get ProductgramFont {
  return GoogleFonts.alice(
      textStyle: TextStyle(
          fontSize:16,
          fontWeight: FontWeight.normal,
          color: Colors.black45
      )
  );
}
TextStyle get ProductPriceFont {
  return GoogleFonts.alice(
      textStyle: TextStyle(
          fontSize:18,
          fontWeight: FontWeight.w700,
          color: Colors.black54
      )
  );
}
TextStyle get ProductdescriFont {
  return GoogleFonts.alice(
      textStyle: TextStyle(
          fontSize:12,
          fontWeight: FontWeight.w700,
          color: Colors.black45
      )
  );
}


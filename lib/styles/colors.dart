import 'package:flutter/material.dart';

class AppColor {
  static const orange = Color(0xFFFC6011);
  static const primary = Color(0xFF1A237E);
  static const greyBackGround = Color(0xFFB6B7B7);
  static const whiteBackground = Color(0xFFF2F2F2);
  static const indigolightBack = Color(0xFFE8EAF6);

  static MaterialColor seaformGreen = MaterialColor(0xFFCDF4DC, {
    50: Color(0xFFFDFFFE),
    100: Color(0xFFFAFEFC),
    200: Color(0xFFF3FDF7),
    300: Color(0xFFEBFBF1),
    400: Color(0xFFDCF8E7),
    500: Color(0xFFCDF4DC),
    600: Color(0xFFB7DAC4),
    700: Color(0xFF7B9384),
    800: Color(0xFF5D6E63),
    900: Color(0xFF3C4740),
  });
  static MaterialColor indigo = MaterialColor(0xFF130170, {
    50: Color(0xFFF4F3F8),
    100: Color(0xFFE8E6F1),
    200: Color(0xFFC4C0DC),
    300: Color(0xFF9F97C5),
    400: Color(0xFF5A4E9B),
    500: Color(0xFF130170),
    600: Color(0xFF110164),
    700: Color(0xFF0C0144),
    800: Color(0xFF090133),
    900: Color(0xFF060121),
  });

  static MaterialColor teal = MaterialColor(0xFF01949A, {
    50: Color(0xFFF3FAFA),
    100: Color(0xFFE6F5F5),
    200: Color(0xFFC0E5E6),
    300: Color(0xFF97D4D6),
    400: Color(0xFF4EB5B9),
    500: Color(0xFF01949A),
    600: Color(0xFF01848A),
    700: Color(0xFF01595D),
    800: Color(0xFF014346),
    900: Color(0xFF012B2D),
  });

  static MaterialColor rose_red = MaterialColor(0xFFCD0046, {
    50: Color(0xFFFDF3F6),
    100: Color(0xFFFAE6ED),
    200: Color(0xFFF3C0D1),
    300: Color(0xFFEB97B4),
    400: Color(0xFFDC4D7E),
    500: Color(0xFFCD0046),
    600: Color(0xFFB7003F),
    700: Color(0xFF7B002A),
    800: Color(0xFF5D0020),
    900: Color(0xFF3C0015),
  });

}

Color get tealColor {
  return AppColor.teal.shade300;
}
Color get tealColorbold {
  return AppColor.teal.shade600;
}

Color get seaformGreenColor {
  return AppColor.seaformGreen.shade300;
}
Color get indigoColor{
  return AppColor.indigo.shade500;
}
Color get roseRedColor{
  return AppColor.rose_red;
}
Color get roseRedColor50{
  return AppColor.rose_red.shade50;
}
Color get indigoBackGroundColor{
  return AppColor.indigo.shade100;
}
Color get seaformGreenColorBold {
  return AppColor.seaformGreen.shade800;
}
Color get seaformGreenColor200 {
  return AppColor.seaformGreen.shade200;
}

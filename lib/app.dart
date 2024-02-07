import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/presentation/routes.dart';
import 'package:grocery_app/presentation/styles/theme.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeData,
      getPages: Routes.routes,
      initialRoute: AppRoutes.splashScreen,
    );
  }
}

import 'package:get/get.dart';
import 'package:grocery_app/presentation/controller/cart_controller.dart';
import 'package:grocery_app/presentation/controller/home_controller.dart';

import '../../injecter.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController(sl(), sl(), sl(), sl(),sl()),
        fenix: true);
    Get.lazyPut(() => CartController(sl(), sl(), sl()));
    // Get.lazyPut(() => AuthController(sl(), sl(),sl()));
  }
}

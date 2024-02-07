import 'package:get/get.dart';
import 'package:grocery_app/presentation/controller/product_controller.dart';

import '../../injecter.dart';

class ProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
        () => ProductController(sl(), sl(), sl(), sl(), sl(), sl(), sl()));
  }
}

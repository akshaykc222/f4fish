import 'package:get/get.dart';
import 'package:grocery_app/domain/usecase/get_token_usercase.dart';
import 'package:grocery_app/domain/usecase/save_token_usercase.dart';
import 'package:grocery_app/presentation/controller/splash_controller.dart';

import '../../injecter.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashController(
        GetTokenUserCase(
          sl(),
        ),
        SaveTokenUserCase(sl())));
  }
}

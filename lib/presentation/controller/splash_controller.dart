import 'package:get/get.dart';
import 'package:grocery_app/domain/usecase/get_token_usercase.dart';
import 'package:grocery_app/domain/usecase/save_token_usercase.dart';
import 'package:grocery_app/presentation/routes.dart';

import '../../core/usecase.dart';

class SplashController extends GetxController {
  final GetTokenUserCase getTokenUserCase;
  final SaveTokenUserCase saveTokenUserCase;
  SplashController(this.getTokenUserCase, this.saveTokenUserCase);

  checkToken() async {
    // await saveTokenUserCase.call("d5a26a9d187cf7525a20fbe0ec59d93b24f28c8c");
    // Get.offAndToNamed(AppRoutes.homescreen);
    try {
      var token = await getTokenUserCase.call(NoParams());

      if (token == "") {
        Get.offAndToNamed(AppRoutes.login);
      } else {
        Get.offAndToNamed(AppRoutes.homescreen);
      }
    } catch (e) {
      print(e);
      Get.offAndToNamed(AppRoutes.login);
    }
  }
}

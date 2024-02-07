import 'package:get/get.dart';
import 'package:grocery_app/domain/usecase/auth_register_otp.dart';
import 'package:grocery_app/domain/usecase/auth_register_usecase.dart';
import 'package:grocery_app/domain/usecase/save_token_usercase.dart';
import 'package:grocery_app/injecter.dart';
import 'package:grocery_app/presentation/controller/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
        () => AuthController(SaveTokenUserCase(sl()), AuthRegisterUseCase(sl()),
            AuthRegisterOtpUseCase(sl()), sl(), sl(), sl()),
        fenix: true);
  }
}

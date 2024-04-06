import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/core/response_classify.dart';
import 'package:grocery_app/core/usecase.dart';
import 'package:grocery_app/domain/entity/user_entity.dart';
import 'package:grocery_app/domain/usecase/add_address_use_case.dart';
import 'package:grocery_app/domain/usecase/auth_register_otp.dart';
import 'package:grocery_app/domain/usecase/auth_register_usecase.dart';
import 'package:grocery_app/domain/usecase/get_user_user_case.dart';
import 'package:grocery_app/domain/usecase/logout_usecase.dart';
import 'package:grocery_app/domain/usecase/save_token_usercase.dart';
import 'package:grocery_app/presentation/helpers/enums.dart';
import 'package:grocery_app/presentation/routes.dart';

class AuthController extends GetxController {
  final SaveTokenUserCase saveTokenUserCase;
  final AuthRegisterUseCase authRegisterUseCase;
  final AuthRegisterOtpUseCase authRegisterOtpUseCase;
  final GetUserUseCaseAddress getUserUseCase;
  final AddAddressUseCase addAddressUseCase;
  final LogoutUseCase logoutUseCase;
  AuthController(
      this.saveTokenUserCase,
      this.authRegisterUseCase,
      this.authRegisterOtpUseCase,
      this.logoutUseCase,
      this.getUserUseCase,
      this.addAddressUseCase);
//controllers
  final formKey = GlobalKey<FormState>();
  late final phone = TextEditingController();
  final password = TextEditingController();
  late final otp = TextEditingController();
  final response = ResponseClassify.error("").obs;
  final otpResponse = ResponseClassify.error("").obs;
  final addressList = <AddressEntity>[].obs;

  void logOut() {
    logoutUseCase.call(NoParams());
  }

  //to generate otp
  void getOtp(String phone) async {
    if (otp.text.isNotEmpty) {
      otpResponse.value = ResponseClassify.loading();
      try {
        otpResponse.value = ResponseClassify.completed(
            await authRegisterOtpUseCase
                .call({'mobile': phone, 'token': otp.text}));
        saveTokenUserCase.call(otpResponse.value.data['token']);
        Get.offAndToNamed(AppRoutes.homescreen);
      } catch (e) {
        otpResponse.value = ResponseClassify.error(e.toString());
        Get.snackbar("Invalid OTP", "$e");
      }
    } else {
      Get.snackbar("Enter OTP", "Please enter otp to continue");
    }
  }

  //verify otp after entering
  void login() async {
    logOut();
    if (formKey.currentState?.validate() == true) {
      if (response.value.status != Status.LOADING) {
        response.value = ResponseClassify.loading();
        try {
          var data = await authRegisterUseCase
              .call(LoginModel(phone.text, password.text));
          response.value = ResponseClassify.completed(NoParams());
          saveTokenUserCase.call(data.token);
          Get.toNamed(AppRoutes.otp, arguments: phone.text);
          // formKey.currentState?.reset();
          // response.value = ResponseClassify.completed(await authRegisterUseCase.call(phone));
        } catch (e) {
          Get.snackbar('Error', "Invalid username or password",
              backgroundColor: Colors.black, colorText: Colors.white);
          print(e);

          response.value = ResponseClassify.error(e.toString());
        }
      }
    }
  }

  final registerForm = GlobalKey<FormState>();
  void registerF() async {
    logOut();
    if (registerForm.currentState!.validate()) {
      print("REGISTER ${registerForm.currentState!.validate()}");
      response.value = ResponseClassify.loading();
      try {
        var data = LoginResponseModel.fromJson(await authRegisterOtpUseCase
            .call({'mobile': phone.text, 'token': password.text}));

        await saveTokenUserCase.call(data.token);
        response.value = ResponseClassify.completed(NoParams());

        Get.toNamed(
          AppRoutes.homescreen,
        );
        registerForm.currentState?.reset();
        // response.value = ResponseClassify.completed(await authRegisterUseCase.call(phone));
      } catch (e) {
        String error = "";

        Get.snackbar('Error', "Invalid username or password",
            backgroundColor: Colors.black, colorText: Colors.white);
        print(e);

        response.value = ResponseClassify.error(e.toString());
      }
    }
  }

  final getUserDataResponse = ResponseClassify<UserEntity>.error("").obs;

  Future getUserData() async {
    getUserDataResponse.value = ResponseClassify.loading();
    try {
      getUserDataResponse.value = ResponseClassify<UserEntity>.completed(
          await getUserUseCase.call(NoParams()));
      if (getUserDataResponse.value.data!.address.isNotEmpty) {
        changeSelectedAddress(getUserDataResponse.value.data!.address.first);
      }
      refresh();
    } catch (e) {
      print(e);
      getUserDataResponse.value = ResponseClassify.error(e.toString());
    }
  }

  final addingData = false.obs;
  final addressFormKey = GlobalKey<FormState>();
  var addAddressResponse = ResponseClassify.error("").obs;
  addUserData(AddressEntity address) async {
    // if(addressList.contains(address)){
    //   addressList.remove(address);
    //   addressList.add(address);
    // }else{
    //   addressList.add(address);
    // }
    // getUserDataResponse.value.data!.address.clear();
    addingData.value = true;
    debugPrint(getUserDataResponse.value.data.toString());
    getUserDataResponse.value.data!.address.add(address);
    addAddressResponse.value = ResponseClassify.loading();
    try {
      addAddressResponse.value = ResponseClassify.completed(
          await addAddressUseCase.call(getUserDataResponse.value.data!));
      shouldRefresh.value = true;
      getUserData().then((value) => Get.offNamedUntil(
          AppRoutes.address, ModalRoute.withName(AppRoutes.checkOut)));
    } catch (e) {
      getUserData().then((value) => Get.back());
      addAddressResponse.value = ResponseClassify.error(e.toString());
    }
    addingData.value = false;
  }

  final addressType = AddressType.HOME.obs;
  changeAddressType(AddressType type) {
    addressType.value = type;
  }

  final selectedAddress = Rxn<AddressEntity>();
  changeSelectedAddress(AddressEntity entity) {
    print("changing value");
    selectedAddress.value = entity;
  }

  var shouldRefresh = false.obs;
}

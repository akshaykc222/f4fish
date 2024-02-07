import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/app_constants.dart';
import 'package:grocery_app/core/response_classify.dart';
import 'package:grocery_app/presentation/controller/auth_controller.dart';
import 'package:grocery_app/presentation/styles/colors.dart';
import 'package:grocery_app/presentation/widgets/big_text.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../routes.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final controller = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    showRegister() {
      showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (context) => Form(
            key: controller.registerForm,
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Wrap(
                children: <Widget>[
                  Center(
                    child: Container(
                        constraints: const BoxConstraints(maxHeight: 340),
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          "Register",
                          style: Theme.of(context).textTheme.headlineLarge,
                        )),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    // height: 40,
                    constraints: const BoxConstraints(maxWidth: 500),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: IntlPhoneField(
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                      ),
                      initialCountryCode: 'IN',
                      onChanged: (phone) {
                        controller.phone.text = phone.completeNumber;
                      },
                    ),
                  ),
                  Container(
                    // height: 40,
                    constraints: const BoxConstraints(maxWidth: 500),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: TextFormField(
                      controller: controller.password,
                      validator: (val) {
                        if (val == null || val.length < 6) {
                          return "Password needs to have at least 6 characters";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    constraints: const BoxConstraints(maxWidth: 500),
                    child: controller.response.value.status ==
                        Status.LOADING
                        ? Center(
                      child: CircularProgressIndicator(),
                    )
                        : ElevatedButton(
                      onPressed: () {
                        controller.registerF();
                      },
                      // color: MyColors.primaryColor,
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              AppColors.primaryColor)),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 8),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Register',
                              style: TextStyle(color: Colors.black54),
                            ),
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(20)),
                                // color: MyColors.primaryColorLight,
                              ),
                              child:
                              controller.response.value.status ==
                                  Status.LOADING
                                  ? CircularProgressIndicator(
                                color: Colors.white,
                              )
                                  : Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                                size: 16,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ));
    }

    return Scaffold(
      body: Form(
        key: controller.formKey,
        child: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: ListView(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: Stack(
                        children: <Widget>[
                          Center(
                            child: Container(
                              height: 240,
                              constraints: const BoxConstraints(maxWidth: 500),
                              margin: const EdgeInsets.only(top: 100),
                              decoration: BoxDecoration(
                                  color: Color(0xFFE1E0F5),
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/login_banner.jpg')),
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                            ),
                          ),
                          Center(
                            child: Container(
                                constraints:
                                const BoxConstraints(maxHeight: 340),
                                margin:
                                const EdgeInsets.symmetric(horizontal: 8),
                                child: Text(
                                  "Login",
                                  style:
                                  Theme.of(context).textTheme.headlineLarge,
                                )),
                          ),
                        ],
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(AppConstants.appName,
                            style: TextStyle(
                                color: Colors.indigo.shade800,
                                fontSize: 30,
                                fontWeight: FontWeight.w800,
                            )))
                  ],
                ),
                Column(
                  children: <Widget>[
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      // height: 40,
                      constraints: const BoxConstraints(maxWidth: 500),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: SizedBox(
                        width: 300,
                        child: IntlPhoneField(
                          decoration: InputDecoration(
                            labelText: 'Phone Number',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(),
                            ),
                          ),
                          initialCountryCode: 'IN',
                          onChanged: (phone) {
                            controller.phone.text = phone.completeNumber;
                          },
                        ),
                      ),
                    ),
                    /*Container(
                      // height: 40,
                      constraints: const BoxConstraints(maxWidth: 500),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: TextFormField(
                       
                        decoration: InputDecoration(
                          labelText: 'otp',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(),
                          ),
                        ),
                      ),
                    ),*/
                    /*Obx(()=>Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      constraints: const BoxConstraints(maxWidth: 500),
                      child: ElevatedButton(
                        onPressed: () {
                          controller.login();
                          Get.toNamed(AppRoutes.otp,arguments: controller.phone.text);

                        },
                        // color: MyColors.primaryColor,
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                AppColors.primaryColor)),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Login',
                                style: TextStyle(color: Colors.white),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20)),
                                  // color: MyColors.primaryColorLight,
                                ),
                                child: controller.response.value.status ==
                                    Status.LOADING
                                    ? CircularProgressIndicator(
                                  color: Colors.white,
                                )
                                    : Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )),*/
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(
                          AppRoutes.otp, arguments: controller.phone.text,);
                        controller.login();
                      },
                      child: Container(
                        height: 50,
                        width: 300,
                        decoration: BoxDecoration(
                            color: Colors.indigo,
                            borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                        child: Center(
                          child: BigText(text: "Login",color: Colors.white,size: 20,),
                        ),
                      ),
                    )
    /*OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.green),
                        onPressed: () {
                          Get.toNamed(AppRoutes.otp,arguments: controller.phone.text                                                                                                             );
                        },
                        child: Text("Register?"))
                  */
    ],
    )
    ],
    ),
    ),
    ),
    ),
    );
    }
}

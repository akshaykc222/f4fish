import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:grocery_app/app_constants.dart';
import 'package:grocery_app/core/response_classify.dart';
import 'package:grocery_app/presentation/routes.dart';

import '../../../common_widgets/app_text.dart';
import '../../controller/auth_controller.dart';
import '../../helpers/column_with_seprator.dart';
import '../../styles/colors.dart';
import '../../widgets/buttons.dart';
import 'account_item.dart';

class AccountScreen extends StatelessWidget {
  final authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      authController.getUserData();
    });

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade50,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                spacer30,
                backButton(),
                SizedBox(
                  height: 100,
                  child: Obx(
                    () => authController.getUserDataResponse.value.status ==
                            Status.LOADING
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 20,
                              ),
                              Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                      color: Colors.black12,
                                      borderRadius: BorderRadius.circular(10))),
                              SizedBox(
                                width: 20,
                              ),
                              Container(
                                  height: 60,
                                  width: 200,
                                  decoration: BoxDecoration(
                                      color: Colors.black12,
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10))))
                            ],
                          )
                        : Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              spacerW10,
                              SizedBox(
                                  width: 30,
                                  height: 30,
                                  child: getImageHeader()),
                              spacerW10,
                              AppText(
                                text: authController.getUserDataResponse.value
                                        .data?.mobile ??
                                    "",
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ],
                          ),
                  ),
                ),
                spacer20,

                ///Account items like orders,noti,help...
                SizedBox(
                  child: Text(
                    "Orders",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black26),
                  ),
                ),
                spacer20,
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade200,
                        offset: const Offset(
                          0.0,
                          0.0,
                        ),
                        blurRadius: 10.0,
                        spreadRadius: 5.0,
                      ), //BoxShadow
                      BoxShadow(
                        color: Colors.grey.shade200,
                        offset: const Offset(-5.0, -2.0),
                        blurRadius: 10.0,
                        spreadRadius: 5.0,
                      ), //BoxShadow
                    ],
                  ),
                  child: Column(children: [
                    Column(
                      children: getChildrenWithSeperator(
                          widgets: accountItems.map((e) {
                            return getAccountItemWidget(e);
                          }).toList(),
                          seperator: spacer30),
                    ),
                  ]),
                ),
                spacer30,

                ///Account items like orders,noti,help...
                SizedBox(
                  child: Text(
                    "Support",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black26),
                  ),
                ),
                spacer20,
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade200,
                        offset: const Offset(
                          0.0,
                          0.0,
                        ),
                        blurRadius: 10.0,
                        spreadRadius: 5.0,
                      ), //BoxShadow
                      BoxShadow(
                        color: Colors.grey.shade200,
                        offset: const Offset(-5.0, -2.0),
                        blurRadius: 10.0,
                        spreadRadius: 5.0,
                      ), //BoxShadow
                    ],
                  ),
                  child: Column(children: [
                    Column(
                      children: getChildrenWithSeperator(
                          widgets: moreItems.map((e) {
                            return getAccountItemWidget(e);
                          }).toList(),
                          seperator: spacer30),
                    ),
                  ]),
                ),
                spacer30,
                _ratingButton(),
                spacer30,

                ///logout button
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _logoutButton(),
                        spacer30,
                        _versionText(),
                        spacer30
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _logoutButton() {
    return GestureDetector(
      onTap: () {
        authController.logOut();
        Get.offNamed(AppRoutes.login);
      },
      child: Container(
        height: 40,
        width: 130,
        padding: EdgeInsets.symmetric(horizontal: 5),
        margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              offset: const Offset(
                0.0,
                0.0,
              ),
              blurRadius: 10.0,
              spreadRadius: 5.0,
            ), //BoxShadow
            BoxShadow(
              color: Colors.grey.shade200,
              offset: const Offset(-5.0, -2.0),
              blurRadius: 10.0,
              spreadRadius: 5.0,
            ), //BoxShadow
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: 15,
              height: 15,
              child: SvgPicture.asset(
                "assets/icons/account_icons/logout_icon.svg",
              ),
            ),
            Text(
              "Logout",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor),
            ),
          ],
        ),
      ),
    );
  }

  Widget _ratingButton() {
    return GestureDetector(
      onTap: () {
        authController.logOut();
        Get.offNamed(AppRoutes.login);
      },
      child: Container(
        height: 60,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              offset: const Offset(
                0.0,
                0.0,
              ),
              blurRadius: 10.0,
              spreadRadius: 5.0,
            ), //BoxShadow
            BoxShadow(
              color: Colors.grey.shade200,
              offset: const Offset(-5.0, -2.0),
              blurRadius: 10.0,
              spreadRadius: 5.0,
            ), //BoxShadow
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.thumb_up,
              color: Colors.black38,
              size: 25,
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              "Rate us on play store",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }

  Widget getImageHeader() {
    String imagePath = "assets/images/account_image.png";
    return CircleAvatar(
      radius: 5.0,
      backgroundImage: AssetImage(
        imagePath,
      ),
      backgroundColor: AppColors.primaryColor.withOpacity(0.7),
    );
  }

  Widget _versionText() {
    return SizedBox(
      child: Text(
        "v.0.0.1(100)",
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.indigo.shade100),
      ),
    );
  }

  Widget getAccountItemWidget(AccountItem accountItem) {
    return InkWell(
      onTap: () => accountItem.onTap(),
      child: Row(
        children: [
          Icon(accountItem.iconPath!, color: Colors.black38, size: 25),
          SizedBox(
            width: 20,
          ),
          Text(
            accountItem.label,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
          Spacer(),
          Icon(
            Icons.arrow_forward_ios,
            size: 15,
            color: Colors.black26,
          )
        ],
      ),
    );
  }
}

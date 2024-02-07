import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:grocery_app/presentation/controller/home_controller.dart';
import 'package:grocery_app/presentation/screens/dashboard/navigator_item.dart';

import '../../styles/colors.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return Obx(() => Scaffold(
          body: navigatorItems[controller.selectedBottomIndex.value].screen,
          bottomNavigationBar: Container(
            constraints: BoxConstraints(maxWidth: 500),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(15),
                topLeft: Radius.circular(15),
              ),
              boxShadow: [
                BoxShadow(
                    color: Colors.black38.withOpacity(0.1),
                    spreadRadius: 0,
                    blurRadius: 37,
                    offset: Offset(0, -12)),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              child: BottomNavigationBar(
                backgroundColor: Colors.white,
                currentIndex: controller.selectedBottomIndex.value,
                onTap: (index) {
                  controller.changeSelectedBottomIndex(index);
                },
                type: BottomNavigationBarType.fixed,
                selectedItemColor: AppColors.primaryColor,
                selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
                unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
                unselectedItemColor: Colors.black,
                items: navigatorItems.map((e) {
                  return getNavigationBarItem(
                      label: e.label, index: e.index, iconPath: e.iconPath);
                }).toList(),
              ),
            ),
          ),
        ));
  }
}

BottomNavigationBarItem getNavigationBarItem(
    {String? label, String? iconPath, int? index}) {
  final controller = Get.find<HomeController>();
  Color iconColor = index == controller.selectedBottomIndex.value
      ? AppColors.primaryColor
      : Colors.black;
  return BottomNavigationBarItem(
    label: label,
    icon: SvgPicture.asset(
      iconPath ?? "",
      color: iconColor,
    ),
  );
}

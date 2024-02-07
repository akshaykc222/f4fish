import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/presentation/routes.dart';

class AccountItem {
  final String label;
  final IconData? iconPath;
  final Function onTap;

  AccountItem(
      {required this.label, this.iconPath, required this.onTap});

}

List<AccountItem> accountItems = [
  AccountItem(
      label: "Orders",
      iconPath: Icons.card_travel,
      onTap: () => Get.toNamed(AppRoutes.orders)),
  AccountItem(
      label: "Delivery Addresses",
      iconPath: Icons.home_max_outlined,
      onTap: () => {Get.toNamed(AppRoutes.address)}),
   AccountItem(
       label: "Notifications",
      iconPath: Icons.notification_important,
       onTap: () => {}),

];
/*
List<AccountItem> coupenItems = [

  AccountItem(
      label: "Coupons",
     // iconPath: "assets/icons/account_icons/orders_icon.svg",
      onTap: () => Get.toNamed(AppRoutes.orders)),

];
*/
List<AccountItem> moreItems = [

  AccountItem(
      label: "Get Help",
      iconPath: Icons.live_help,
      onTap: () => {}),
  AccountItem(
      label: "Terms & Conditions",
      iconPath: Icons.my_library_books_sharp,
      onTap: () => {}),
  AccountItem(
      label: "About Us",
      iconPath: Icons.account_balance_outlined,
      onTap: () => {}),

];

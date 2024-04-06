import 'package:get/get.dart';
import 'package:grocery_app/presentation/bindings/auth_binding.dart';
import 'package:grocery_app/presentation/bindings/home_binding.dart';
import 'package:grocery_app/presentation/bindings/product_binding.dart';
import 'package:grocery_app/presentation/bindings/splash_binding.dart';
import 'package:grocery_app/presentation/screens/account/account_screen.dart';
import 'package:grocery_app/presentation/screens/account/address_screen.dart';
import 'package:grocery_app/presentation/screens/auth/otp_page.dart';
import 'package:grocery_app/presentation/screens/auth/register.dart';
import 'package:grocery_app/presentation/screens/cart/cart_screen.dart';
import 'package:grocery_app/presentation/screens/cart/checkout_bottom_sheet.dart';
import 'package:grocery_app/presentation/screens/driver/home.dart';
import 'package:grocery_app/presentation/screens/home/home_screen.dart';
import 'package:grocery_app/presentation/screens/home/location_screen.dart';
import 'package:grocery_app/presentation/screens/orders.dart';
import 'package:grocery_app/presentation/screens/product_details/product_list.dart';
import 'package:grocery_app/presentation/screens/splash_screen.dart';
import 'package:grocery_app/presentation/time_slots.dart';

class Routes {
  static final routes = [
    GetPage(
        name: AppRoutes.splashScreen,
        page: () => SplashScreen(),
        bindings: [SplashBinding(), HomeBinding()]),
    GetPage(
        name: AppRoutes.cart,
        page: () => CartScreen(),
        bindings: [HomeBinding()]),
    GetPage(
        name: AppRoutes.login,
        page: () => LoginPage(),
        bindings: [AuthBinding()]),
    GetPage(
        name: AppRoutes.otp, page: () => OtpPage(), bindings: [AuthBinding()]),
    GetPage(
        name: AppRoutes.account,
        page: () => AccountScreen(),
        bindings: [AuthBinding(), ProductBinding(), HomeBinding()]),
    GetPage(
        name: AppRoutes.homescreen,
        page: () => HomeScreen(),
        bindings: [AuthBinding(), ProductBinding(), HomeBinding()]),
    /*GetPage(
        name: AppRoutes.dashBoard,
        page: () => DashboardScreen(),
        bindings: [HomeBinding(), AuthBinding()]),*/
    GetPage(
        name: AppRoutes.address,
        page: () => AddressScreen(),
        bindings: [HomeBinding()]),
    GetPage(
        name: AppRoutes.location,
        page: () => LocationScreen(),
        bindings: [HomeBinding()]),
    GetPage(
        name: AppRoutes.orders,
        page: () => OrdersList(),
        bindings: [ProductBinding()]),
    GetPage(
        name: AppRoutes.products,
        page: () => ProductListScreen(),
        bindings: [ProductBinding()]),
    GetPage(
        name: AppRoutes.driverHome,
        page: () => DriverHome(),
        binding: ProductBinding()),
    GetPage(
      name: AppRoutes.timeSlots,
      page: () => DateTimeSlot(),
    ),
    GetPage(name: AppRoutes.checkOut, page: () => CheckoutBottomSheet())
  ];
}

class AppRoutes {
  static const splashScreen = "/splash";
  static const login = "/login";
  static const timeSlots = "/timeslots";
  static const checkOut = "/checkOut";
  static const account = "/account";
  static const homescreen = "/homescreen";
  static const cart = "/cart";
  static const otp = "/otp";
  static const productDetails = "/productDetails";
  static const dashBoard = "/dashboard";
  static const address = "/address";
  static const orders = "/orders";
  // static const address = "/address";
  static const location = "/location";
  static const products = "/products";
  static const driverHome = "/driver";
  // static const products_list = "/products_list";
}

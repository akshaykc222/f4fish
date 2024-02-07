import 'package:badges/badges.dart' as badges;

///apply badges to cart icon

///apply badges to cart icon
///apply badges to cart icon
///apply badges to cart icon

///apply badges to cart icon
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pelaicons/pelaicons.dart';

import '../../core/response_classify.dart';
import '../../injecter.dart';
import '../../styles/colors.dart';
import '../../styles/themes.dart';

///apply badges to cart icon
import '../controller/cart_controller.dart';
import '../routes.dart';
import 'big_text.dart';

// ADD TO CART BUTTON
Widget get addToCartButton {
  return Container(
    height: 30,
    width: 75,
    padding: EdgeInsets.all(3),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(5)),
      border: Border.all(
        width: 1,
        color: AppColor.rose_red.shade500,
      ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.remove,
          color: AppColor.rose_red.shade500,
          size: 12,
        ),
        VerticalDivider(width: 8, color: AppColor.rose_red.shade500),
        Text(
          "ADD",
          style: buttonfont,
        ),
        VerticalDivider(
          width: 8,
          color: AppColor.rose_red.shade500,
        ),
        Icon(Icons.add, color: AppColor.rose_red.shade500, size: 12),
      ],
    ),
  );
}
//////////////////////////////

//SELECT BUTTON
Widget get selectProductButton {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
    height: 30,
    width: 60,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(5)),
      border: Border.all(
        width: 1,
        color: Colors.green.shade800,
      ),
    ),
    child: GestureDetector(
      child: Center(
        child: Text("SELECT ", style: SelectButton),

        /*Row(
          mainAxisAlignment: MainAxisAlignment.start,

          children: [
            Text("SELECT",style:SelectButton),
            Icon(Icons.navigate_next_outlined,color: Colors.green.shade800,)

          ],
        ),*/
      ),
    ),
  );
}

///////////////////////////////
/// remove button
class removeButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.delete_forever_outlined,
            size: 15,
            color: Colors.black54,
          ),
          Text(
            "Remove",
            style: TextStyle(
                color: Colors.black54,
                fontSize: 12,
                fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }
}

/// CIRCULAR AVATAR BACK BUTTON
class backButtonAvatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => Navigator.pop(context),
        child: CircleAvatar(
          backgroundColor: Colors.black12,
          radius: 20,
          child: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
            size: 18,
          ),
        ));
  }
}

/// BACK BUTTON
class backButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Icon(
          Icons.arrow_back_ios_new,
          color: Colors.black,
          size: 20,
        ));
  }
}

///cart button
class cartButton extends StatelessWidget {
  @override
  final cartController = Get.put(CartController(sl(), sl(), sl()));

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: cartController.getCartResponse.value.status == Status.LOADING
          ? GestureDetector(
              onTap: () => Get.toNamed(AppRoutes.cart),
              child: CircleAvatar(
                backgroundColor: Colors.black12,
                radius: 20,
                child: Icon(
                  Pelaicons.cart_2_light_outline,
                  color: Colors.white,
                  size: 18,
                ),
              ))
          : badges.Badge(
              position: badges.BadgePosition.topEnd(top: -5, end: -6),
              child: GestureDetector(
                  onTap: () => Get.toNamed(AppRoutes.cart),
                  child: CircleAvatar(
                    backgroundColor: Colors.black12,
                    radius: 20,
                    child: Icon(
                      Pelaicons.cart_2_light_outline,
                      color: Colors.white,
                      size: 18,
                    ),
                  )),
              badgeStyle: badges.BadgeStyle(
                shape: badges.BadgeShape.circle,
                badgeColor: Colors.indigo.shade400,
                borderRadius: BorderRadius.circular(13),
                elevation: 0,
              ),
              badgeContent: BigText(
                text: cartController.cartList.value?.data.products.length
                        .toString() ??
                    "",
                color: Colors.white,
                size: 13,
              ),
            ),
    );
  }
}

class backButtonn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: CircleAvatar(
        backgroundColor: Colors.white24,
        radius: 20,
        child: Icon(
          Icons.backspace_rounded,
          color: Colors.white,
        ),
      ),
    );
  }
}

class favariteButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: CircleAvatar(
          backgroundColor: seaformGreenColor,
          child: Icon(
            Icons.favorite_border,
            color: Colors.blueGrey,
            size: 20,
          ),
          radius: 20,
        ),
      ),
    );
  }
}

class shareButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: CircleAvatar(
            backgroundColor: Colors.black12,
            radius: 20,
            child: Icon(
              Icons.share_outlined,
              color: Colors.white,
              size: 18,
            ),
          )),
    );
  }
}
/////////////////////

//MORE BUTTON
Widget get moreButton {
  return TextButton(
      onPressed: () => null,
      child: Text(
        "more..",
        style: moreFont,
      ));
}

//////////////////////////////

class BoxrouteContainer extends StatelessWidget {
  String heading;
  double? height;
  double? width;
  IconData? icon;
  Color? color;
  BoxrouteContainer(
      {Key? key,
      required this.heading,
      this.height,
      this.width,
      this.icon,
      this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(8),
        height: height ?? 40,
        width: width ?? 100,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: color ?? tealColorbold),
        child: Center(
            child: Text(
          heading,
          style: (color == Colors.white) ? buttonBlackHeading : buttonHeading,
        )));
  }
}

class AddRouteContainer extends StatelessWidget {
  String heading;
  double? height;
  double? width;
  IconData? icon;
  Color? color;
  AddRouteContainer(
      {Key? key,
      required this.heading,
      this.height,
      this.width,
      this.icon,
      this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(8),
      height: height ?? 40,
      width: width ?? 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          color: Colors.green.shade500),
      child: Center(child: Text("ADD", style: ADDHeading)),
    );
  }
}

/////////////////////////////////

////////////////////////////////

class routeContainerProfile extends StatelessWidget {
  IconData selectedIcon;
  String selectText;
  String? routeName;

  routeContainerProfile(
      {Key? key,
      this.routeName,
      required this.selectedIcon,
      required this.selectText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListTile(
        contentPadding: EdgeInsets.all(1),
        horizontalTitleGap: 8,
        selectedTileColor: Colors.grey,
        minVerticalPadding: 1,
        leading: CircleAvatar(
          child: Icon(
            selectedIcon,
            color: Colors.black38,
            size: 16,
          ),
          backgroundColor: Colors.grey.shade100,
          radius: 15,
        ),
        tileColor: Colors.white,
        title: Text(
          selectText,
          style: profileHeading,
          textScaleFactor: 1.5,
        ),
        trailing: Icon(
          Icons.navigate_next_outlined,
          size: 30,
          color: Colors.black38,
        ),
        selected: true,
        onTap: () {
          Navigator.pushNamed(context, routeName!);
        },
      ),
    );
  }
}
////////////////////////////////////

class BoxrouteProfileContainer extends StatelessWidget {
  String heading;
  double? height;
  double? width;
  IconData? icon;

  BoxrouteProfileContainer(
      {Key? key, required this.heading, this.height, this.width, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(8),
        height: height ?? 100,
        width: width ?? 140,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: Colors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(
              icon,
              color: Colors.black54,
              size: 30,
            ),
            Text(
              heading,
              style: profilebuttonHeading,
            ),
          ],
        ));
  }
}

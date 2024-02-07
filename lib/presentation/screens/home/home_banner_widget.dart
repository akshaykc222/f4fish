import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/app_constants.dart';
import 'package:grocery_app/core/response_classify.dart';

import '../../controller/home_controller.dart';

class HomeBanner extends StatelessWidget {
  final controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.response.value.status == Status.LOADING
        ? Center(
            child: CircularProgressIndicator(),
          )
        : controller.response.value.data?.offers.isEmpty == true ||
                controller.response.value.data?.offers == null
            ? SizedBox()
            : CarouselSlider(
                options: CarouselOptions(
                  height: 150,
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.8,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: true,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                ),
                items: controller.response.value.data?.offers.map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        height: 300,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.black,
                            image: DecorationImage(
                                image: NetworkImage(
                                  "${AppConstants.imagePath}${i.offerImage}",
                                ),
                                fit: BoxFit.fill)),
                      );
                    },
                  );
                }).toList()));
  }
}

import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:awesome_place_search/awesome_place_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/app_constants.dart';
import 'package:grocery_app/common_widgets/app_text.dart';
import 'package:grocery_app/core/response_classify.dart';
import 'package:grocery_app/presentation/controller/home_controller.dart';
import 'package:grocery_app/presentation/routes.dart';
import 'package:grocery_app/presentation/styles/colors.dart';
import 'package:grocery_app/presentation/widgets/buttons.dart';
import 'package:grocery_app/presentation/widgets/shimmer_widget.dart';

import '../../widgets/big_text.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  PredictionModel? prediction;
  TextEditingController textEditor = TextEditingController();
  @override
  Widget build(BuildContext context) {
    _searchPlaces() {
      return AwesomePlaceSearch(
        context: context,
        key: "Your Google map key", //Insert Your google Api Key
        onTap: (value) async {
          final result = await value;
          setState(() {
            prediction = result;
          });
        },
      ).show();
    }

    ;
    final controller = Get.find<HomeController>();
    controller.getAllLocation();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        leading: backButton(),
        title: Padding(
            padding: EdgeInsets.symmetric(horizontal: 50),
            child: BigText(
              color: Colors.black87,
              text: "Select Location",
              size: 20,
            )),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Obx(() => controller.allLocationResponse.value.status ==
                    Status.LOADING
                ? SizedBox(
                    height: 700,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          spacer30,

                          /// Anime search bar
                          Shimmerwidget.rectangular(
                            height: 40,
                            width: 150,
                          ),
                          spacer20,

                          ///current location selecetor
                          Shimmerwidget.rectangular(
                            height: 40,
                          ),
                          spacer30,

                          ///default locations

                          spacer30,
                          spacer30,

                          ///list of pincode locations
                          SizedBox(
                            height: 300,
                            child: ListView.builder(
                                itemCount: 5,
                                itemBuilder: (context, index) {
                                  return buildFoodShimmer();
                                }),
                          ),
                        ],
                      ),
                    ))
                : controller.allLocationResponse.value.status == Status.ERROR
                    ? Center(
                        child: AppText(
                          text: controller.allLocationResponse.value.error
                              .toString(),
                        ),
                      )
                    : controller.allLocationResponse.value.data!.isEmpty
                        ? Center(
                            child: AppText(
                              text: "No Locations Found",
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                /// Anime search bar
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    AnimSearchBar(
                                      width: 200,
                                      searchIconColor: AppColors.primaryColor,
                                      textController: textEditor,
                                      onSuffixTap: () {
                                        setState(() {
                                          textEditor.clear();
                                        });
                                      },
                                      onSubmitted: (String s) {
                                        controller.getAllLocation(pinCode: s);
                                      },
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    BigText(
                                      text: "Pincode",
                                      color: Colors.black,
                                      size: 20,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                ),

                                ///current location selecetor
                                InkWell(
                                  onTap: () => controller.getNearestLocation(),
                                  child: Container(
                                    height: 40,
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.transparent),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Spacer(
                                          flex: 1,
                                        ),
                                        Icon(
                                          Icons.place,
                                          size: 20,
                                          color: Colors.deepPurple,
                                        ),
                                        Spacer(
                                          flex: 1,
                                        ),
                                        BigText(
                                          color: Colors.deepPurple,
                                          text: "Use current location",
                                          size: 18,
                                        ),
                                        Spacer(
                                          flex: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                SizedBox(
                                  height: 30,
                                ),

                                ///default locations
                                Row(
                                  children: [
                                    Expanded(
                                      child: Divider(
                                        indent: 10,
                                        endIndent: 10,
                                        color: Colors.black54,
                                      ),
                                    ),
                                    BigText(
                                      text: "select city",
                                      size: 18,
                                      color: Colors.black,
                                    ),
                                    Expanded(
                                      child: Divider(
                                        indent: 10,
                                        endIndent: 10,
                                        color: Colors.black54,
                                      ),
                                    )
                                  ],
                                ),
                                spacer20,

                                ///list of pincode locations
                                SizedBox(
                                  height: 100 *
                                      controller.allLocationResponse.value.data!
                                          .length
                                          .toDouble(),
                                  child: ListView.builder(
                                      itemCount: controller.allLocationResponse
                                          .value.data?.length,
                                      itemBuilder: (context, index) {
                                        var item = controller
                                            .allLocationResponse
                                            .value
                                            .data![index];
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Container(
                                            height: 40,
                                            width: double.infinity,
                                            margin: EdgeInsets.symmetric(
                                                vertical: 15),
                                            child: ListTile(
                                              onTap: () {
                                                controller
                                                    .saveLocalLocation(item);
                                               Get.back();
                                              },
                                              leading: Icon(
                                                Icons.factory_sharp,
                                                color:
                                                    Colors.deepPurple.shade300,
                                              ),
                                              title: AppText(
                                                text: item.name,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              subtitle: Text(item.pinCode),
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                              ],
                            ),
                          )),
          ],
        ),
      ),
    );
  }

  Widget buildFoodShimmer() => ListTile(
        title: Shimmerwidget.rectangular(
          height: 40,
          width: 200,
        ),
      );
}

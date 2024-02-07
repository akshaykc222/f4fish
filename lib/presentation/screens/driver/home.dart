import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:grocery_app/presentation/styles/colors.dart';

import '../../../core/response_classify.dart';
import '../../../injecter.dart';
import '../../controller/home_controller.dart';
import '../../controller/product_controller.dart';
import '../../routes.dart';
import '../orders.dart';

class DriverHome extends StatefulWidget {
  const DriverHome({Key? key}) : super(key: key);

  @override
  State<DriverHome> createState() => _DriverHomeState();
}

class _DriverHomeState extends State<DriverHome> {
  String selected = "pending";
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: SizedBox(),
        bottom: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width, 90),
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    selected = "pending";
                  });
                },
                child: Container(
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(18)),
                  child: Text(
                    "Pending",
                    style: TextStyle(
                        color: selected != "completed"
                            ? Colors.red
                            : Colors.white),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    selected = "completed";
                  });
                },
                child: Container(
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(18)),
                  child: Text(
                    "Completed",
                    style: TextStyle(
                        color: selected == "completed"
                            ? Colors.red
                            : Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: selected == "completed" ? CompletedOrders() : PendingOrders(),
    );
  }
}

Widget padded(Widget widget) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 25),
    child: widget,
  );
}

Widget locationWidget(BuildContext context) {
  String locationIconPath = "assets/icons/location_icon.svg";
  final controller = Get.put(HomeController(sl(), sl(), sl(), sl(),sl()));
  return PreferredSize(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            locationIconPath,
          ),
          SizedBox(
            width: 8,
          ),
          Obx(() => controller.location.value == null
              ? TextButton(
                  onPressed: () {
                    Get.toNamed(AppRoutes.location);
                  },
                  child: Text("Change Location"))
              : TextButton(
                  onPressed: () {
                    Get.toNamed(AppRoutes.location);
                  },
                  child: Text(
                    controller.location.value?.name ?? "",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ))),
          // Icon(Icons.edit)
        ],
      ),
      preferredSize: Size(MediaQuery.of(context).size.width, 80));
}

class PendingOrders extends StatefulWidget {
  const PendingOrders({Key? key}) : super(key: key);

  @override
  State<PendingOrders> createState() => _PendingOrdersState();
}

class _PendingOrdersState extends State<PendingOrders> {
  final controller = Get.find<ProductController>();

  @override
  void initState() {
    controller.getStaffOrders(filter: "status=PENDING");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SizedBox(
            height: 5,
          ),
          SizedBox(
            height: 5,
          ),
          Obx(() => controller.orderStaffResponse.value.status == Status.LOADING
              ? Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                  ),
                )
              : Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller
                              .orderStaffResponse.value.data?.data.length ??
                          0,
                      itemBuilder: (context, index) => OrderTile(
                          fromDel: true,
                          data: controller
                              .orderStaffResponse.value.data!.data[index]))))
        ],
      ),
    );
  }
}

class CompletedOrders extends StatefulWidget {
  const CompletedOrders({Key? key}) : super(key: key);

  @override
  State<CompletedOrders> createState() => _CompletedOrdersState();
}

class _CompletedOrdersState extends State<CompletedOrders> {
  final controller = Get.find<ProductController>();

  @override
  void initState() {
    controller.getStaffOrders(filter: "status=DELIVERED");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.orderStaffResponse.value.status ==
            Status.LOADING
        ? Center(
            child: CircularProgressIndicator(
              color: AppColors.primaryColor,
            ),
          )
        : ListView.builder(
            shrinkWrap: true,
            itemCount:
                controller.orderStaffResponse.value.data?.data.length ?? 0,
            itemBuilder: (context, index) {
              var item = controller.orderStaffResponse.value.data?.data[index];
              return Card(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                item?.address.name ?? "",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              Text(item?.address.address ?? "")
                            ],
                          ),
                        ),
                        Expanded(
                            child: Text(
                          "DELIVERED",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ))
                      ],
                    ),
                    Row(
                      children: [
                        Text(item?.createdDate.toString() ?? ""),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(item?.paymentRef.type ?? ""),
                            Text(item?.paymentRef.orderAmount.toString() ?? "")
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              );
            }));
  }
}

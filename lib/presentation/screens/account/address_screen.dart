import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:grocery_app/app_constants.dart';
import 'package:grocery_app/common_widgets/app_button.dart';
import 'package:grocery_app/core/response_classify.dart';
import 'package:grocery_app/presentation/controller/auth_controller.dart';
import 'package:grocery_app/presentation/helpers/enums.dart';
import 'package:grocery_app/presentation/styles/colors.dart';
import 'package:grocery_app/presentation/widgets/buttons.dart';
import 'package:grocery_app/presentation/widgets/location_chooser.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../domain/entity/user_entity.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({Key? key}) : super(key: key);

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final controller = Get.find<AuthController>();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getUserData();
    });
    super.initState();
  }

  refreshCallBack() {
    controller.getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: backButton(),
        title: Text(
          "Address",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.green.shade700),
        ),
        elevation: 0,
      ),
      body: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 500),
          child: Stack(
            children: [
              Column(
                children: [
                  spacer30,
                  Obx(() {
                    print("SHOULD REFRESH :${controller.shouldRefresh.value}");

                    return controller.getUserDataResponse.value.status ==
                            Status.LOADING
                        ? Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primaryColor,
                            ),
                          )
                        : Expanded(
                            child: controller.getUserDataResponse.value.data!
                                    .address.isEmpty
                                ? Center(
                                    child: Text("No address found !"),
                                  )
                                : ListView.separated(
                                    itemBuilder: (context, index) {
                                      var data = controller.getUserDataResponse
                                          .value.data?.address[index];
                                      return Obx(() => Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: ListTile(
                                              leading: Checkbox(
                                                onChanged: (bool? value) {
                                                  controller
                                                      .changeSelectedAddress(
                                                          data!);
                                                },
                                                value: controller
                                                        .selectedAddress
                                                        .value
                                                        ?.id ==
                                                    data?.id,
                                              ),
                                              onTap: () {
                                                controller
                                                    .changeSelectedAddress(
                                                        data!);
                                              },
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              tileColor:
                                                  Colors.green.withOpacity(0.4),
                                              // selectedColor: Colors.blue.withOpacity(0.2),
                                              selectedTileColor:
                                                  Colors.green.withOpacity(0.4),
                                              // selected: controller.selectedAddress.value?.id ==
                                              //     data?.id,
                                              title: Text(
                                                  "Name : ${data?.name ?? ""}\nPhone Number : ${data?.phoneNumber ?? ""}\nAddress : ${data?.address ?? ''}"),
                                            ),
                                          ));
                                    },
                                    separatorBuilder: (context, index) =>
                                        Divider(
                                          color: Colors.grey,
                                        ),
                                    itemCount: controller.getUserDataResponse
                                            .value.data?.address.length ??
                                        0));
                  })
                ],
              ),
              Positioned(
                  bottom: 20,
                  left: 80,
                  right: 100,
                  child: AppButton(
                    onPressed: () {
                      Get.back();
                    },
                    label: 'Select',
                  ))
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => AddressAddScreen());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class AddressAddFrom extends StatelessWidget {
  const AddressAddFrom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();
    return Form(
      key: controller.addressFormKey,
      child: Column(
        children: [TextFormField()],
      ),
    );
  }
}

// Future<void> main() async {
//   await init();
//   runApp(MaterialApp(
//     home: AddressAddScreen(),
//   ));
// }

class AddressAddScreen extends StatelessWidget {
  const AddressAddScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<String> getAddressFromLatLng(
        double latitude, double longitude) async {
      try {
        List<Placemark> placemarks =
            await placemarkFromCoordinates(latitude, longitude);
        Placemark place = placemarks[0];
        return "${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
      } catch (e) {
        return "";
      }
    }

    final controller = Get.find<AuthController>();
    // final controller =
    //     Get.put(AuthController(sl(), sl(), sl(), sl(), sl(), sl()));
    final phoneController = TextEditingController();
    final nameController = TextEditingController();
    final addressController = TextEditingController();
    String phoneNumber = "";
    ValueNotifier<LatLng?> selectedLocation = ValueNotifier(null);
    final key = GlobalKey<FormState>();

    return Scaffold(
      bottomNavigationBar: Container(
        height: 60,
        child: Row(
          children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () {
                  Get.back();
                },
                child: Text("Cancel"),
              ),
            )),
            Expanded(
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Obx(
                      () => controller.addAddressResponse.value.status ==
                              Status.LOADING
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primaryColor),
                              onPressed: () async {
                                if (selectedLocation.value == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text("Select location")));
                                } else {
                                  if (key.currentState!.validate()) {
                                    controller.addUserData(
                                      AddressEntity(
                                        phoneNumber: phoneNumber,
                                        name: nameController.text,
                                        type: controller.addressType.value.name,
                                        address: await getAddressFromLatLng(
                                            selectedLocation.value?.latitude ??
                                                0,
                                            selectedLocation.value?.longitude ??
                                                0),
                                        lat: selectedLocation.value?.latitude ??
                                            0,
                                        long:
                                            selectedLocation.value?.longitude ??
                                                0,
                                      ),
                                    );
                                  }
                                }
                              },
                              child: Text("Save"),
                            ),
                    )))
          ],
        ),
      ),
      body: SafeArea(
        top: true,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: key,
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Add Address",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25.0, vertical: 8),
                  child: TextFormField(
                    controller: nameController,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return "Enter Name";
                      }
                      return null;
                    },
                    decoration:
                        InputDecoration(labelText: "Name", hintText: "Name"),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25.0, vertical: 8),
                  child: IntlPhoneField(
                    controller: phoneController,
                    initialCountryCode: 'IN',
                    onChanged: (phone) {
                      phoneNumber = phone.completeNumber;
                    },
                    decoration: InputDecoration(
                        labelText: "Phone Number", hintText: "Phone Number"),
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: AddressType.values.toList().length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          controller.changeAddressType(
                              AddressType.values.toList()[index]);
                        },
                        child: Obx(() => Container(
                              height: 30,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: controller.addressType.value ==
                                              AddressType.values.toList()[index]
                                          ? Colors.orange
                                          : Colors.green)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  AddressType.values.toList()[index].name,
                                  style: TextStyle(
                                      color: controller.addressType.value ==
                                              AddressType.values.toList()[index]
                                          ? Colors.orange
                                          : Colors.green),
                                ),
                              ),
                            )),
                      ),
                    ),
                  ),
                ),
                spacer10,
                GestureDetector(
                  onTap: () {
                    Get.to(LocationChooser((result) {
                      Get.back();
                      selectedLocation.value = result;
                      selectedLocation.notifyListeners();
                    }));
                  },
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.gps_fixed,
                          color: Colors.blue,
                        ),
                      ),
                      Text(
                        "Select Location",
                        style: TextStyle(color: Colors.blue),
                      )
                    ],
                  ),
                ),
                // Padding(
                //   padding:
                //       const EdgeInsets.symmetric(horizontal: 25.0, vertical: 8),
                //   child: TextFormField(
                //     controller: addressController,
                //     maxLines: 5,
                //     validator: (val) {
                //       if (val == null || val.length < 5) {
                //         return "Enter complete address";
                //       }
                //       return null;
                //     },
                //     decoration: InputDecoration(
                //         labelText: "Address", hintText: "Address"),
                //   ),
                // ),
                SizedBox(
                  height: 10,
                ),
                ValueListenableBuilder<LatLng?>(
                    valueListenable: selectedLocation,
                    builder: (context, data, child) {
                      return data != null
                          ? FutureBuilder(
                              future: getAddressFromLatLng(
                                  data.latitude, data.longitude),
                              builder: (context, d) {
                                return d.hasData
                                    ? Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(d.data as String))
                                    : SizedBox();
                              })
                          : SizedBox();
                    })

                // ElevatedButton(
                //     onPressed: () {
                //       if (key.currentState!.validate()) {
                //         controller.addUserData(AddressEntity(
                //             phoneNumber: phoneNumber,
                //             name: nameController.text,
                //             type: controller.addressType.value.name,
                //             address: addressController.text));
                //         Get.back();
                //       }
                //     },
                //     child: Text("Save"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AddressCard extends StatelessWidget {
  final Map<String, dynamic> data;
  final bool selected;
  const AddressCard({Key? key, required this.data, required this.selected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> items = [];
    data.forEach((key, value) {
      items.add(Row(
        children: [
          Text(key.toString()),
          Text(value.toString()),
        ],
      ));
    });
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: selected
              ? AppColors.primaryColor.withOpacity(0.4)
              : Colors.orange.withOpacity(0.5)),
      child: Column(
        children: items,
      ),
    );
  }
}

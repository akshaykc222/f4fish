import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/app_constants.dart';
import 'package:grocery_app/common_widgets/app_button.dart';
import 'package:grocery_app/core/response_classify.dart';
import 'package:grocery_app/domain/entity/user_entity.dart';
import 'package:grocery_app/presentation/controller/auth_controller.dart';
import 'package:grocery_app/presentation/helpers/enums.dart';
import 'package:grocery_app/presentation/styles/colors.dart';
import 'package:grocery_app/presentation/widgets/buttons.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

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
                  Obx(() => controller.getUserDataResponse.value.status ==
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
                                              value: controller.selectedAddress
                                                      .value?.id ==
                                                  data?.id,
                                            ),
                                            onTap: () {
                                              controller
                                                  .changeSelectedAddress(data!);
                                            },
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15)),
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
                                  separatorBuilder: (context, index) => Divider(
                                        color: Colors.grey,
                                      ),
                                  itemCount: controller.getUserDataResponse
                                          .value.data?.address.length ??
                                      0)))
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
          Get.dialog(AddressAddScreen());
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

class AddressAddScreen extends StatelessWidget {
  const AddressAddScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();
    final phoneController = TextEditingController();
    final nameController = TextEditingController();
    final addressController = TextEditingController();
    String phoneNumber = "";
    final key = GlobalKey<FormState>();

    return Dialog(
      child: Container(
        child: Form(
          key: key,
          child: Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
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
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25.0, vertical: 8),
                child: TextFormField(
                  controller: addressController,
                  maxLines: 5,
                  validator: (val) {
                    if (val == null || val.length < 5) {
                      return "Enter complete address";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: "Address", hintText: "Address"),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (key.currentState!.validate()) {
                      controller.addUserData(AddressEntity(
                          phoneNumber: phoneNumber,
                          name: nameController.text,
                          type: controller.addressType.value.name,
                          address: addressController.text));
                      Get.back();
                    }
                  },
                  child: Text("Save"))
            ],
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

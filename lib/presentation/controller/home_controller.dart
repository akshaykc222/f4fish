import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grocery_app/common_widgets/app_button.dart';
import 'package:grocery_app/common_widgets/app_text.dart';
import 'package:grocery_app/core/response_classify.dart';
import 'package:grocery_app/core/usecase.dart';
import 'package:grocery_app/data/remote/model/region_model.dart';
import 'package:grocery_app/domain/entity/home_entity.dart';
import 'package:grocery_app/domain/usecase/home_use_case.dart';
import 'package:location/location.dart';

import '../../core/custom_exception.dart';
import '../../domain/usecase/get_all_locations.dart';
import '../../domain/usecase/location_use_case.dart';
import '../routes.dart';

class HomeController extends GetxController {
  // final CategoryUseCase categoryUseCase;
  // final SubCategoryUseCase subCategoryUseCase;
  //final OfferUserCase offerUserCase;
  //
  // HomeController(this.categoryUseCase, this.subCategoryUseCase, this.offerUserCase) {
  //   getCategories();
  // }
  //
  // final categoryResponse = ResponseClassify<CategoryEntity>.loading().obs;
  // final subCategoryResponse = ResponseClassify<CategoryEntity>.loading().obs;
  // final offerResponse =ResponseClassify.loading().obs;
  // getCategories() async {
  //   categoryResponse.value = ResponseClassify.loading();
  //   try {
  //     categoryResponse.value =
  //         ResponseClassify.completed(await categoryUseCase.call(NoParams()));
  //   } catch (e) {
  //     categoryResponse.value = ResponseClassify.error(e.toString());
  //   }
  // }
  //
  // getSubCategories(int id) async {
  //   categoryResponse.value = ResponseClassify.loading();
  //   try {
  //     categoryResponse.value =
  //         ResponseClassify.completed(await subCategoryUseCase.call(id));
  //   } catch (e) {
  //     categoryResponse.value = ResponseClassify.error(e.toString());
  //   }
  // }
  // getOffers()

  final HomeUseCase useCase;
  final GetAllLocationsUseCase allLocationsUseCase;
  final GetNearestLocation nearestLocation;
  final GetLocalLocationUseCase getLocation;
  final SaveLocationUseCase saveLocation;

  HomeController(this.useCase, this.allLocationsUseCase, this.nearestLocation,
      this.getLocation, this.saveLocation) {
    // getAllLocation();
    getHome();
    getLocalLocation();
  }
  /*
  change pincode varible value search
   */
  String? pincode;
  final response = ResponseClassify<HomeEntity>.loading().obs;
  final allLocationResponse = ResponseClassify<List<RegionModel>>.loading().obs;
  final nearestLocationResponse = ResponseClassify<RegionModel>.loading().obs;
  getAllLocation({String? pinCode}) async {
    allLocationResponse.value = ResponseClassify.loading();
    try {
      allLocationResponse.value =
          ResponseClassify.completed(await allLocationsUseCase.call(pinCode));
      print("products length : ${response.value.data?.products.length}");
    } on UnauthorisedException {
      GetStorage storage = GetStorage();
      storage.remove("token");
      Get.offAllNamed(AppRoutes.login);
    } catch (e) {
      print("error" + e.toString());
      response.value = ResponseClassify.error(e.toString());
    }
  }

  getHome() async {
    if (location.value?.id == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.toNamed(AppRoutes.location);
      });
    } else {
      response.value = ResponseClassify.loading();
      // try {
      response.value = ResponseClassify.completed(
          await useCase.call(location.value?.id ?? 1));
      print("products length : ${response.value.data?.products.length}");
      // } on UnauthorisedException {
      //   GetStorage storage = GetStorage();
      //   storage.remove("token");
      //   Get.offAllNamed(AppRoutes.login);
      // } catch (e) {
      //   print(e.toString());
      //   response.value = ResponseClassify.error(e.toString());
      // }
    }
  }

  final selectedBottomIndex = 0.obs;
  changeSelectedBottomIndex(int index) {
    selectedBottomIndex.value = index;
  }

  saveLocalLocation(RegionModel region) async {
    await saveLocation.call(region);
    getLocalLocation();
  }

  final location = Rxn<RegionModel>();
  getLocalLocation() async {
    print("getting nearest location ");
    location.value = getLocation.call(NoParams());
    print("getting location${location.value}");
    if (location.value?.id == null) {
      await getNearestLocation();
    } else {
      getHome();
    }
  }

  Future<LocationData?> determinePosition() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return null;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    _locationData = await location.getLocation();
    return _locationData;
  }

  getNearestLocation() async {
    nearestLocationResponse.value = ResponseClassify.loading();
    try {
      LocationData? p = await determinePosition();

      print(p?.latitude);
      if (p != null) {
        nearestLocationResponse.value = ResponseClassify.completed(
            await nearestLocation.call({
          'lat': p.latitude.toString(),
          'long': p.longitude.toString()
        }));
        saveLocation.call(nearestLocationResponse.value.data!);
        getLocalLocation();
      }
    } catch (e) {
      Get.dialog(Dialog(
        child: Wrap(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  AppText(
                    text: "Sorry !",
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Image.asset(
                    "assets/images/sad.png",
                    width: 50,
                    height: 50,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  AppText(text: "Please select location"),
                  SizedBox(
                    height: 20,
                  ),
                  AppButton(
                    label: "Select",
                    onPressed: () {
                      Get.toNamed(AppRoutes.location);
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ));
      nearestLocationResponse.value = ResponseClassify.error(e.toString());
      print("err" + e.toString());
    }
  }
}

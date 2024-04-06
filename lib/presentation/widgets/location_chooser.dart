import 'dart:async';

// import 'package:awesome_place_search/awesome_place_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_location_search/flutter_location_search.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationChooser extends StatefulWidget {
  final Function(LatLng) onTap;
  const LocationChooser(this.onTap);

  @override
  State<LocationChooser> createState() => _LocationChooserState();
}

class _LocationChooserState extends State<LocationChooser> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  static const CameraPosition _kBangalore = CameraPosition(
    target: LatLng(12.971598, 77.594562), // Coordinates for Bangalore
    zoom: 14.0,
  );
  LatLng? selectedLocation;
  Set<Marker> markers = {};

  TextEditingController searchController = TextEditingController();
  final ValueNotifier<Set<Circle>> _circles = ValueNotifier({});
  final ValueNotifier<Set<Marker>> _markers = ValueNotifier({});
  //
  // addFromList() {
  //   for (var e in blocState.regionList) {
  //     _onMapTap(LatLng(e.latitude, e.longitude));
  //   }
  // }

  @override
  void initState() {
    // addFromList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: getAppBar(
      //     context,
      //     const Text(
      //       "Choose Location",
      //       style: TextStyle(fontSize: 18),
      //     )),
      body: SafeArea(
        bottom: true,
        top: true,
        child: Stack(
          children: [
            ValueListenableBuilder(
                valueListenable: _markers,
                builder: (context, markers, child) {
                  return ValueListenableBuilder(
                      valueListenable: _circles,
                      builder: (context, circles, child) {
                        return GoogleMap(
                          mapType: MapType.normal,
                          onTap: (val) {
                            _onMapTap(val);
                            // addFromList();
                          },
                          markers: _markers.value,
                          myLocationButtonEnabled: true,
                          myLocationEnabled: true,
                          onMapCreated: (GoogleMapController controller) {
                            _controller.complete(controller);
                          },
                          initialCameraPosition: _kBangalore,
                        );
                      });
                }),
            GestureDetector(
              onTap: () async {
                LocationData? result = await LocationSearch.show(
                    context: context, mode: Mode.fullscreen);
                _markers.value.clear();
                selectedLocation =
                    LatLng(result?.latitude ?? 0, result?.longitude ?? 0);
                var controller = await _controller.future;
                controller.animateCamera(CameraUpdate.newCameraPosition(
                    CameraPosition(
                        target: selectedLocation!,
                        tilt: 59.440717697143555,
                        zoom: 19.151926040649414)));
                _markers.value.add(
                  Marker(
                    position:
                        LatLng(result?.latitude ?? 0, result?.longitude ?? 0),
                    markerId: MarkerId("selected_id"),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 6, left: 16, right: 80),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: TextField(
                      enabled: false,
                      decoration: InputDecoration(
                          hintText: "Search Places ...",
                          disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 1),
                              borderRadius: BorderRadius.circular(20)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)))),
                ),
              ),
            ),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: ValueListenableBuilder(
                    valueListenable: _markers,
                    builder: (context, data, child) {
                      return selectedLocation == null
                          ? const SizedBox()
                          : Container(
                              height: 55,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15)),
                              child: ElevatedButton(
                                onPressed: () {
                                  // Navigator.pop(context);
                                  widget.onTap(selectedLocation!);
                                },
                                child: const Text("Select"),
                              ));
                    }))
          ],
        ),
      ),
    );
  }

  void _onMapTap(LatLng tappedPoint) {
    // setState(() {
    selectedLocation = tappedPoint;
    _markers.value.clear();

    _markers.value.add(
      Marker(
        markerId: const MarkerId('selected-location'),
        position: tappedPoint,
        infoWindow: const InfoWindow(
          title: 'Selected Location',
          snippet: 'Tap again to place marker',
        ),
      ),
    );
    _addCircle(tappedPoint);
    // });
  }

  Future<void> _addCircle(LatLng center) async {
    _circles.value.add(Circle(
      circleId: const CircleId('selected-circle'),
      center: center,
      radius: 5000, // 5 km in meters
      fillColor: Colors.blue.withOpacity(0.3),
      strokeWidth: 0,
    ));
    _markers.notifyListeners();
    _circles.notifyListeners();
  }
}

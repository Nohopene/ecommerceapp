import 'package:ecommerceapp/screens/deliveryaddress/widget/add_address.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../../providers/location_provider.dart';

class CurrentLocationScreenState extends StatefulWidget {
  static const String id = 'map-screen';
  const CurrentLocationScreenState({super.key});

  @override
  State<CurrentLocationScreenState> createState() =>
      _CurrentLocationScreenStateState();
}

class _CurrentLocationScreenStateState
    extends State<CurrentLocationScreenState> {
  late GoogleMapController googleMapController;

  bool _locating = false;

  late LatLng currentLocation;
  @override
  Widget build(BuildContext context) {
    final locationData = Provider.of<LocationProvider>(context);

    setState(() {
      currentLocation = LatLng(locationData.latitude, locationData.longitude);
    });

    void onCreated(GoogleMapController controller) {
      setState(() {
        googleMapController = controller;
      });
    }

    return SafeArea(
      child: Scaffold(
        body: Stack(children: [
          GoogleMap(
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            initialCameraPosition:
                CameraPosition(target: currentLocation, zoom: 16.4),
            mapType: MapType.normal,
            mapToolbarEnabled: true,
            onMapCreated: onCreated,
            onCameraMove: (CameraPosition position) {
              setState(() {
                _locating = true;
              });
              locationData.onCamereMove(position);
            },
            onCameraIdle: () {
              setState(() {
                _locating = false;
              });
              locationData.getMoveCamera();
            },
          ),
          Center(
            child: Container(
              height: 30,
              margin: const EdgeInsets.only(bottom: 20),
              child: Image.asset(
                'assets/images/icons8-location-48.png',
                color: Colors.red,
              ),
            ),
          ),
          Positioned(
              bottom: 0.0,
              child: Container(
                height: 130,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _locating
                          ? LinearProgressIndicator(
                              backgroundColor: Colors.transparent,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Theme.of(context).primaryColor),
                            )
                          : Container(),
                      TextButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.location_searching),
                        label: _locating
                            ? const Text(
                                'Locating....',
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black),
                              )
                            : Text(
                                locationData.selectedAddress.addressLine,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black),
                              ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 40,
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(
                                      builder: (context) => AddAddressScreen(
                                            address: locationData
                                                .selectedAddress.addressLine,
                                          )));
                            },
                            child: const Text('Confirm address')),
                      )
                    ],
                  ),
                ),
              ))
        ]),
      ),
    );
  }
}

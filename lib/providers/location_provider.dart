// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceapp/services/address_service.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationProvider with ChangeNotifier {
  late double latitude;
  late double longitude;
  // ignore: prefer_typing_uninitialized_variables
  var selectedAddress;
  List addressList = [];
  QuerySnapshot? snapshot;

  AddressService _addressService = AddressService();

  Future<void> getCurrentPosition() async {
    LocationPermission permission = await await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      print('Permission not given');
    } else {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      latitude = position.latitude;
      longitude = position.longitude;

      final coordinates = Coordinates(latitude, longitude);
      final addresses =
          await Geocoder.local.findAddressesFromCoordinates(coordinates);
      selectedAddress = addresses.first;
      notifyListeners();
    }
  }

  void onCamereMove(CameraPosition cameraPosition) async {
    latitude = cameraPosition.target.latitude;
    longitude = cameraPosition.target.longitude;
    notifyListeners();
  }

  Future<void> getMoveCamera() async {
    final coordinates = Coordinates(latitude, longitude);
    final addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    selectedAddress = addresses.first;
    print("${selectedAddress.featureName} : ${selectedAddress.addressLine}");
  }

  String name = '';
  String phone = '';
  String address = '';

  Future<void> getAdress() async {
    QuerySnapshot snapshot = await _addressService.addresss
        .doc(_addressService.user!.uid)
        .collection('address')
        .where('status', isEqualTo: true)
        .get();

    snapshot.docs.forEach((doc) {
      name = doc['name'];
      phone = doc['phone'];
      address = doc['address'];
      notifyListeners();
    });
    this.snapshot = snapshot;
    notifyListeners();
  }
}

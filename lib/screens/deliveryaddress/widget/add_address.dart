import 'package:ecommerceapp/constanst/color_constant.dart';
import 'package:ecommerceapp/providers/location_provider.dart';
import 'package:ecommerceapp/screens/deliveryaddress/deliveyaddress_screen.dart';
import 'package:ecommerceapp/screens/deliveryaddress/widget/googlemap_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../services/address_service.dart';
import '../../../widget/circle_icon_button.dart';

class AddAddressScreen extends StatefulWidget {
  static const String id = 'addaddress-screen';
  const AddAddressScreen({super.key, this.address});
  final String? address;

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  bool isDefaultAddress = false;
  AddressService addressService = AddressService();
  User? user = FirebaseAuth.instance.currentUser;
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var addressController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final locationData = Provider.of<LocationProvider>(context);

    setState(() {
      if (widget.address == null) {
        addressController.text = '';
      } else {
        addressController.text = widget.address.toString();
      }
    });

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade300,
        appBar: header(),
        body: Column(children: [
          Container(
            margin: const EdgeInsets.only(top: 5, left: 5),
            height: 15,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Address',
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: TextField(
              readOnly: true,
              controller: addressController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                  fillColor: Colors.white, filled: true, hintText: 'Address'),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: InkWell(
              onTap: () async {
                await locationData.getCurrentPosition().then((value) =>
                    Navigator.pushReplacementNamed(
                        context, CurrentLocationScreenState.id));
              },
              child: Ink(
                height: 50,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('Use Google Map'),
                      Icon(Icons.arrow_right_rounded)
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(7),
            height: 15,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Contact',
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
          TextField(
            controller: nameController,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
                fillColor: Colors.white, filled: true, hintText: 'Name'),
          ),
          const SizedBox(
            height: 5,
          ),
          TextField(
            controller: phoneController,
            inputFormatters: [
              LengthLimitingTextInputFormatter(10),
            ],
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
                fillColor: Colors.white, filled: true, hintText: 'Phone'),
          ),
          const Divider(
            height: 1,
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 50,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    ('Put this is default address'),
                  ),
                  CupertinoSwitch(
                    value: isDefaultAddress,
                    onChanged: (bool value) {
                      setState(() {
                        isDefaultAddress = value;
                      });
                    },
                    activeColor: primaryColor,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
                width: MediaQuery.of(context).size.width - 40,
                child: ElevatedButton(
                  onPressed: () async {
                    addressService
                        .saveAddress(
                            name: nameController.text,
                            phone: phoneController.text,
                            address: addressController.text,
                            status: isDefaultAddress)
                        .then((value) => Navigator.popAndPushNamed(
                            context, AddressScreen.id));
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      foregroundColor: const Color(0xFF0D0D0E),
                      elevation: 0,
                      fixedSize: const Size(double.infinity, 40),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                  child: const Text('Confirm'),
                )),
          )
        ]),
      ),
    );
  }

  PreferredSize header() {
    return PreferredSize(
      preferredSize: Size.fromHeight(6.h),
      child: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        flexibleSpace: Padding(
          padding: EdgeInsets.symmetric(horizontal: 1.5.h, vertical: 1.h),
          child: Row(
            children: [
              CircleIconButton(
                size: 14,
                svgIcon: 'assets/icons/cancel.svg',
                color: const Color(0xFFF5F6F9),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              const Spacer(),
              const Text(
                'Add address',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

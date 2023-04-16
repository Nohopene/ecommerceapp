import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceapp/constanst/color_constant.dart';
import 'package:ecommerceapp/models/address_model.dart';
import 'package:ecommerceapp/providers/location_provider.dart';
import 'package:ecommerceapp/screens/deliveryaddress/widget/add_address.dart';
import 'package:ecommerceapp/screens/deliveryaddress/widget/delivery_card.dart';
import 'package:ecommerceapp/screens/deliveryaddress/widget/googlemap_widget.dart';
import 'package:ecommerceapp/services/address_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../widget/circle_icon_button.dart';

class AddressScreen extends StatefulWidget {
  static const String id = 'address-screen';
  const AddressScreen({super.key, this.address});
  final String? address;
  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  AddressService _service = AddressService();
  @override
  Widget build(BuildContext context) {
    final locationData = Provider.of<LocationProvider>(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade300,
        appBar: header(),
        body: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Column(children: [
            DeliveryCard(
              query: addressQuery(),
            ),
            TextButton.icon(
                onPressed: () {
                  Navigator.popAndPushNamed(context, AddAddressScreen.id);
                },
                icon: const Icon(Icons.add),
                label: const Text('Add new address'))
          ]),
        ),
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
                'My Location',
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

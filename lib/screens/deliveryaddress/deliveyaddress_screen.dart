import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../widget/circle_icon_button.dart';
import '../../widget/location_widget.dart';

class AddressScreen extends StatefulWidget {
  static const String id = 'address-screen';
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade300,
        appBar: header(),
        body: Column(children: [
          // Form(
          //   child: Padding(
          //     padding: const EdgeInsets.all(16.0),
          //     child: TextFormField(
          //       onChanged: (value) {},
          //       textInputAction: TextInputAction.search,
          //       decoration: InputDecoration(
          //         contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          //         hintText: 'Search your location',
          //         prefixIcon: Padding(
          //           padding: const EdgeInsets.symmetric(vertical: 12),
          //           child: SvgPicture.asset(
          //             'assets/icons/location.svg',
          //             color: const Color(0xFF585858),
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          const Divider(
            height: 4,
            thickness: 4,
            color: Color(0xFFF8F8F8),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: SvgPicture.asset(
                'assets/icons/navigation.svg',
                height: 16,
              ),
              label: const Text('User my Current Location'),
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFEEEEEE),
                  foregroundColor: const Color(0xFF0D0D0E),
                  elevation: 0,
                  fixedSize: const Size(double.infinity, 40),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)))),
            ),
          ),
          const Divider(
            height: 4,
            thickness: 4,
            color: Color(0xFFF8F8F8),
          ),
          LocationListTitle(
            location: 'Thanh Xuan, Ha Noi, Viet Nam',
            press: () {},
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

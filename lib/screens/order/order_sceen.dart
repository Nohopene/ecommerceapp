import 'package:ecommerceapp/screens/order/widget/order_card.dart';
import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';

import '../../widget/circle_icon_button.dart';

class OrderScreen extends StatefulWidget {
  static const String id = 'order-screen';
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.grey.shade200,
            appBar: header(),
            body: const OrderCard()));
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
                'My Order',
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

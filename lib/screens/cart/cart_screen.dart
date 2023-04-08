import 'package:ecommerceapp/screens/cart/widget/cart_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:line_icons/line_icons.dart';
import 'package:sizer/sizer.dart';

import '../../widget/circle_icon_button.dart';

class CartScreen extends StatefulWidget {
  static const String id = 'cart-screen';
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: Header(context),
      backgroundColor: Colors.grey.shade200,
      body: ListView(
        children: [
          Column(
            children: [CartCard()],
          )
        ],
      ),
    ));
  }

  PreferredSize Header(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(6.5.h),
      child: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        flexibleSpace: Padding(
          padding: EdgeInsets.symmetric(horizontal: 1.5.h),
          child: Row(
            children: [
              CircleIconButton(
                size: 14,
                svgIcon: 'assets/icons/cancel.svg',
                color: Color(0xFFF5F6F9),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              const Spacer(),
              Text(
                'Cart',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(
                  Icons.clear_all_outlined,
                  size: 25,
                ),
                onPressed: () {
                  print('12312312313');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

import '../constanst/color_constant.dart';
import '../providers/cart_provider.dart';
import 'package:badges/badges.dart' as badges;

import '../screens/cart/cart_screen.dart';

// ignore: camel_case_types
class Shoppingbag_Widget extends StatelessWidget {
  const Shoppingbag_Widget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    cartProvider.getCartTotal();
    return badges.Badge(
      position: badges.BadgePosition.topEnd(top: 0, end: 3),
      badgeAnimation: const badges.BadgeAnimation.slide(
        disappearanceFadeAnimationDuration: Duration(milliseconds: 200),
        curve: Curves.easeInCubic,
      ),
      badgeStyle: const badges.BadgeStyle(
        badgeColor: primaryColor,
      ),
      badgeContent: Text(
        cartProvider.cartQty.toString(),
        style: const TextStyle(color: Colors.white),
      ),
      child: IconButton(
          icon: const Icon(LineIcons.shoppingBag),
          onPressed: () {
            Navigator.pushNamed(context, CartScreen.id);
          }),
    );
    // return IconButton(
    //     icon: const Icon(LineIcons.shoppingBag),
    //     onPressed: () {
    //       Navigator.pushNamed(context, CartScreen.id);
    //     });
  }
}

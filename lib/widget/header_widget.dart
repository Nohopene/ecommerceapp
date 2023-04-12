import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:badges/badges.dart' as badges;
import '../constanst/color_constant.dart';
import '../providers/cart_provider.dart';
import '../screens/cart/cart_screen.dart';
import '../screens/home/widget/research_widget.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    super.key,
    required this.context,
  });

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    final _cartProvider = Provider.of<CartProvider>(context);
    _cartProvider.getCartTotal();
    return PreferredSize(
      preferredSize: Size.fromHeight(15.h),
      child: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        flexibleSpace: Stack(children: [
          Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 1.5.h),
                child: Row(
                  children: [
                    const Text(
                      'Peachy',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: primaryColor),
                    ),
                    const Spacer(),
                    badges.Badge(
                      position: badges.BadgePosition.topEnd(top: 0, end: 3),
                      badgeAnimation: const badges.BadgeAnimation.slide(
                        disappearanceFadeAnimationDuration:
                            Duration(milliseconds: 200),
                        curve: Curves.easeInCubic,
                      ),
                      badgeStyle: const badges.BadgeStyle(
                        badgeColor: primaryColor,
                      ),
                      badgeContent: Text(
                        _cartProvider.cartQty.toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                      child: IconButton(
                          icon: const Icon(LineIcons.shoppingBag),
                          onPressed: () {
                            Navigator.pushNamed(context, CartScreen.id);
                          }),
                    ),
                  ],
                ),
              ),
              const ResearchWidget(),
            ],
          ),
        ]),
      ),
    );
  }
}

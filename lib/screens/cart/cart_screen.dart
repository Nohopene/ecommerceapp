import 'package:ecommerceapp/providers/cart_provider.dart';
import 'package:ecommerceapp/screens/cart/widget/cart_card.dart';
import 'package:ecommerceapp/screens/main_screen.dart';
import 'package:ecommerceapp/services/cart_service.dart';
import 'package:ecommerceapp/services/order_service.dart';

import 'package:ecommerceapp/widget/money_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:sizer/sizer.dart';
import 'package:provider/provider.dart';

import '../../constanst/color_constant.dart';

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
    final cartProvider = Provider.of<CartProvider>(context);
    cartProvider.getCartTotal();

    return SafeArea(
      child: Scaffold(
        appBar: header(),
        backgroundColor: Colors.grey.shade200,
        body: cartProvider.cartQty > 0
            ? const CartCard()
            : Center(
                child: Image.asset(
                "assets/images/empty_cart.png",
                width: 20.h,
              )),
        bottomNavigationBar: const CheckOutWidget(),
      ),
    );
  }

  PreferredSize header() {
    CartService service = CartService();
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
                color: const Color(0xFFF5F6F9),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              const Spacer(),
              const Text(
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
                  service.deleteCart();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CheckOutWidget extends StatefulWidget {
  const CheckOutWidget({
    super.key,
  });

  @override
  State<CheckOutWidget> createState() => _CheckOutWidgetState();
}

class _CheckOutWidgetState extends State<CheckOutWidget> {
  OrderService orderService = OrderService();
  User? user = FirebaseAuth.instance.currentUser;
  CartService service = CartService();
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    cartProvider.getCartTotal();
    return Container(
      height: 120,
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 1.5.h, vertical: 1.15.h),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 1.15.h),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: cardShadowColor.withOpacity(0.5),
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset(
                      "assets/icons/receipt.svg",
                      width: 14,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(1.15.h, 0, 1.15.h, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Total:',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        MoneyWidget(
                            size: 14, value: cartProvider.subTotal.toInt())
                      ],
                    ),
                  )
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _saveOrder(cartProvider);
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5))),
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 16.h, vertical: 1.5.h),
                child: const Text(
                  'Check out',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _saveOrder(CartProvider cartProvider) {
    orderService.saveOrder({
      'products': cartProvider.cartList,
      'uid': user?.uid,
      'total': cartProvider.subTotal,
      'orderAt': DateTime.now().toString(),
      'status': 'Process',
      'deliveryAddress': {
        'orderName': '',
        'phone': '',
        'address': '',
      }
    }).then((value) => service
        .deleteCart()
        .then((value) => Navigator.popAndPushNamed(context, MainScreen.id)));
  }
}

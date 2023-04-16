import 'dart:math';

import 'package:ecommerceapp/constanst/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import '../../../models/address_model.dart';
import '../../../providers/cart_provider.dart';
import '../../../providers/location_provider.dart';
import '../../../services/cart_service.dart';
import '../../../services/order_service.dart';
import '../../deliveryaddress/widget/delivery_card.dart';
import '../../main_screen.dart';

class CheckOutBottom extends StatefulWidget {
  const CheckOutBottom({super.key});

  @override
  State<CheckOutBottom> createState() => _CheckOutBottomState();
}

class _CheckOutBottomState extends State<CheckOutBottom> {
  OrderService orderService = OrderService();
  CartService service = CartService();
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    cartProvider.getCartTotal();
    final locationProvider = Provider.of<LocationProvider>(context);
    locationProvider.getAdress();
    String paymentMethod = '';
    return SizedBox(
      height: 250,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 2), // changes position of shadow
                ),
              ],
            ),
            child: DeliveryCard(
              query: addressQuery1(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Button(
                  color: primaryColor,
                  text: 'Cash on Delivery',
                  onpress: () {
                    setState(() {
                      paymentMethod = 'Cash on Delivery';
                    });
                    _saveOrder(cartProvider, locationProvider, paymentMethod);
                  },
                ),
                Button(
                  color: Colors.black,
                  text: 'Credit Card',
                  onpress: () {
                    setState(() {
                      paymentMethod = 'Credit Card';
                    });
                    _saveOrder(cartProvider, locationProvider, paymentMethod);
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  int random(int min, int max) {
    return min + Random().nextInt(max - min);
  }

  _saveOrder(CartProvider cartProvider, LocationProvider locationProvider,
      paymentMethod) {
    orderService.saveOrder({
      'orderId': 'order${random(0, 100000)}',
      'products': cartProvider.cartList,
      'uid': user?.uid,
      'total': cartProvider.subTotal,
      'orderAt': DateTime.now().toString(),
      'status': 'Process',
      'deliveryAddress': {
        'orderName': locationProvider.name,
        'phone': locationProvider.phone,
        'address': locationProvider.address
      },
      'paymenmethod': paymentMethod
    }).then((value) => service
        .deleteCart()
        .then((value) => Navigator.popAndPushNamed(context, MainScreen.id)));
  }
}

class Button extends StatelessWidget {
  const Button({
    super.key,
    required this.text,
    required this.onpress,
    required this.color,
  });
  final String text;
  final VoidCallback onpress;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 170,
        height: 50,
        child: ElevatedButton(
          onPressed: onpress,
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
          child: Text(text),
        ));
  }
}

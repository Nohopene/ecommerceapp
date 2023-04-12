import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceapp/services/cart_service.dart';
import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  CartService _cart = CartService();
  double subTotal = 0.0;
  int cartQty = 0;
  QuerySnapshot? snapshot;
  Future<double?> getCartTotal() async {
    var cartTotal = 0.0;
    QuerySnapshot snapshot =
        await _cart.cart.doc(_cart.user!.uid).collection('products').get();

    if (snapshot == null) {
      return null;
    }
    snapshot.docs.forEach((doc) {
      cartTotal = cartTotal + doc['total'];
    });

    this.subTotal = cartTotal;
    this.cartQty = snapshot.size;
    this.snapshot = snapshot;
    notifyListeners();
    return cartTotal;
  }
}

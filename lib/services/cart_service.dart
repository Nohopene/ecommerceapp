import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceapp/models/product_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../screens/login/otp_screen.dart';
import '../screens/main_screen.dart';

class CartService {
  User? user = FirebaseAuth.instance.currentUser;

  CollectionReference cart = FirebaseFirestore.instance.collection('cart');
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<void> checkCart({required product, required productId}) async {
    DocumentSnapshot snapshot = await cart.doc(user!.uid).get();

    if (snapshot.exists) {
      DocumentSnapshot snapshot1 = await cart
          .doc(user!.uid)
          .collection('products')
          .doc('productId')
          .get();
      if (snapshot1.exists) {
        cart
            .doc(user!.uid)
            .collection('products')
            .where('productId', isEqualTo: productId)
            .get()
            .then((QuerySnapshot querySnapshot) {
          querySnapshot.docs.forEach((doc) {
            print(doc['price']);
          });
        });
      }
    } else {
      addtoCart(product: product, productId: productId);
    }
  }

  Future<void> addtoCart({required product, required productId}) {
    cart.doc(user!.uid).set({
      'user': user!.uid,
    });
    return cart.doc(user!.uid).collection('products').add({
      'productId': productId,
      'name': product.name,
      'image': product.imageUrl,
      'price': product.price,
      'quantity': 1
    });
  }
}

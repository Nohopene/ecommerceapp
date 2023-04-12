import 'package:animated_snack_bar/animated_snack_bar.dart';
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

  // Future<void> checkCart(
  //     {required product, required productId, required context}) async {
  //   DocumentSnapshot snapshot = await cart.doc(user!.uid).get();

  //   if (snapshot.exists) {
  //     cart
  //         .doc(user!.uid)
  //         .collection('products')
  //         .where('productId', isEqualTo: productId)
  //         .get()
  //         .then((QuerySnapshot querySnapshot) => {
  //               querySnapshot.docs.forEach((doc) {
  //                 if (productId == doc['productId']) {
  //                   AnimatedSnackBar.material('Products already in the cart',
  //                           duration: const Duration(seconds: 2),
  //                           type: AnimatedSnackBarType.info,
  //                           mobileSnackBarPosition: MobileSnackBarPosition.top,
  //                           desktopSnackBarPosition:
  //                               DesktopSnackBarPosition.bottomLeft)
  //                       .show(context);
  //                 }
  //               })
  //             });

  //     cart
  //         .doc(user!.uid)
  //         .collection('products')
  //         .where('productId', isEqualTo: productId)
  //         .get()
  //         .then((QuerySnapshot querySnapshot) => {
  //               querySnapshot.docs.forEach((doc) {
  //                 if (doc['productId'] == null) {
  //                   addtoCart(product: product, productId: productId);
  //                 }
  //               })
  //             });
  //   } else {
  //     addtoCart(product: product, productId: productId);
  //     AnimatedSnackBar.material('Add product successful',
  //             duration: const Duration(seconds: 2),
  //             type: AnimatedSnackBarType.success,
  //             mobileSnackBarPosition: MobileSnackBarPosition.bottom,
  //             desktopSnackBarPosition: DesktopSnackBarPosition.bottomLeft)
  //         .show(context);
  //   }
  // }

  Future<void> checkCart(
      {required product, required productId, required context}) async {
    DocumentSnapshot snapshot =
        await cart.doc(user!.uid).collection('products').doc(productId).get();

    if (snapshot.exists) {
      AnimatedSnackBar.material('Products already in the cart',
              duration: const Duration(seconds: 2),
              type: AnimatedSnackBarType.info,
              mobileSnackBarPosition: MobileSnackBarPosition.top,
              desktopSnackBarPosition: DesktopSnackBarPosition.bottomLeft)
          .show(context);
    } else {
      addtoCart(product: product, productId: productId);
      AnimatedSnackBar.material('Add to cart successfully',
              duration: const Duration(seconds: 2),
              type: AnimatedSnackBarType.success,
              mobileSnackBarPosition: MobileSnackBarPosition.top,
              desktopSnackBarPosition: DesktopSnackBarPosition.bottomLeft)
          .show(context);
    }
  }

  Future<void> addtoCart({required product, required productId}) {
    cart.doc(user!.uid).set({
      'user': user!.uid,
    });
    return cart.doc(user!.uid).collection('products').doc(productId).set({
      'productId': productId,
      'name': product.name,
      'imageUrl': product.imageUrl,
      'price': product.price,
      'quantity': 1,
      'total': product.price
    });
  }

  Future<void> updateQtyCart(
      {required productId, required qty, required total}) {
    return cart
        .doc(user!.uid)
        .collection('products')
        .doc(productId)
        .update({'quantity': qty, 'total': total});
  }
}

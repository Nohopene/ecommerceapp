import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';

class CartService {
  User? user = FirebaseAuth.instance.currentUser;

  CollectionReference cart = FirebaseFirestore.instance.collection('cart');
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

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

  Future<void> deleteCart() async {
    await cart.doc(user!.uid).collection('products').get().then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
      }
    });
  }

  Future<void> deleteProductCart({required productId}) async {
    await cart
        .doc(user!.uid)
        .collection('products')
        .where('productId', isEqualTo: productId)
        .get()
        .then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
      }
    });
  }
}

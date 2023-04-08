import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Cart {
  Cart({
    required this.productId,
    required this.name,
    required this.imageUrl,
    required this.quantity,
    required this.price,
  });

  final String? productId;

  final String name;

  final List imageUrl;

  final int quantity;

  final int price;

  Cart.fromJson(Map<String, Object?> json)
      : this(
          productId: json['productId']! as String,
          name: json['name']! as String,
          imageUrl: json['imageUrl']! as List,
          quantity: json['quantity']! as int,
          price: json['price']! as int,
        );

  Map<String, Object?> toJson() {
    return {
      'productId': productId,
      'name': name,
      'imageUrl': imageUrl,
      'quantity': quantity,
      'price': price,
    };
  }
}

User? user = FirebaseAuth.instance.currentUser;

cartQuery() {
  return FirebaseFirestore.instance
      .collection('cart')
      .doc(user!.uid)
      .collection('products')
      .withConverter<Cart>(
          fromFirestore: (snapshot, _) => Cart.fromJson(snapshot.data()!),
          toFirestore: (product, _) => product.toJson());
}

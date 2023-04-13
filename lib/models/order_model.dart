// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OrderModel {
  OrderModel({
    required this.orderName,
    required this.address,
    required this.phone,
    required this.orderAt,
    required this.name,
    required this.imageUrl,
    required this.status,
    required this.total,
    required this.quantity,
    required this.price,
  });

  final String? orderName;
  final String? address;
  final String? phone;
  final String? orderAt;
  final String? name;

  final List imageUrl;
  final String status;
  final int total;
  final int quantity;

  final int price;

  OrderModel.fromJson(Map<String, Object?> json)
      : this(
          orderName:
              json['orderName'] == null ? null : json['orderName']! as String,
          address: json['address'] == null ? null : json['address']! as String,
          phone: json['phone'] == null ? null : json['phone']! as String,
          orderAt: json['orderAt']! as String,
          name: json['name'] == null ? null : json['name']! as String,
          status: json['status']! as String,
          imageUrl: json['imageUrl']! as List,
          quantity: json['quantity']! as int,
          price: json['price']! as int,
          total: json['total']! as int,
        );

  Map<String, Object?> toJson() {
    return {
      'orderName': orderName,
      'address': address,
      'phone': phone,
      'orderAt': orderAt,
      'status': status,
      'total': total,
      'name': name,
      'imageUrl': imageUrl,
      'quantity': quantity,
      'price': price,
    };
  }
}

User? user = FirebaseAuth.instance.currentUser;

orderQuery() {
  return FirebaseFirestore.instance
      .collection('orders')
      .doc(user!.uid)
      .collection('products')
      .withConverter<OrderModel>(
          fromFirestore: (snapshot, _) => OrderModel.fromJson(snapshot.data()!),
          toFirestore: (order, _) => order.toJson());
}

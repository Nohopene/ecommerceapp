// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Address {
  Address({
    required this.name,
    required this.phone,
    required this.address,
    required this.status,
  });

  final String name;

  final String phone;

  final String address;

  final bool status;

  Address.fromJson(Map<String, Object?> json)
      : this(
          name: json['name']! as String,
          phone: json['phone']! as String,
          address: json['address']! as String,
          status: json['status']! as bool,
        );

  Map<String, Object?> toJson() {
    return {
      'name': name,
      'phone': phone,
      'address': address,
      'status': status,
    };
  }
}

User? user = FirebaseAuth.instance.currentUser;

addressQuery() {
  return FirebaseFirestore.instance
      .collection('address')
      .doc(user!.uid)
      .collection('address')
      .withConverter<Address>(
          fromFirestore: (snapshot, _) => Address.fromJson(snapshot.data()!),
          toFirestore: (address, _) => address.toJson());
}

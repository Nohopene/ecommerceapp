import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';

class AddressService {
  User? user = FirebaseAuth.instance.currentUser;

  CollectionReference addresss =
      FirebaseFirestore.instance.collection('address');

  Future<void> saveAddress(
      {required name, required phone, required address, required status}) {
    addresss.doc(user!.uid).set({
      'user': user!.uid,
    });
    return addresss.doc(user!.uid).collection('address').doc().set({
      'uid': user?.uid,
      'name': name,
      'phone': phone,
      'address': address,
      'status': status,
    });
  }
}

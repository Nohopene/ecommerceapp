import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserService {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  User? user = FirebaseAuth.instance.currentUser;
  Future<DocumentReference> saveOrder(Map<String, dynamic> data) {
    var result = users.add(data);
    return result;
  }

  Future<void> updateName({required name}) {
    return users
        .doc(user!.uid)
        .collection('uid')
        .doc(user!.uid)
        .update({'name': name});
  }
}

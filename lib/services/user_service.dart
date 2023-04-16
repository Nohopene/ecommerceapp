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
    return users.doc(user!.uid).update({'name': name});
  }

  Future<void> updateBio({required bio}) {
    return users.doc(user!.uid).update({'bio': bio});
  }

  Future<void> updateGender({required gender}) {
    return users.doc(user!.uid).update({'gender': gender});
  }

  Future<void> updateBirthday({required birthday}) {
    return users.doc(user!.uid).update({'birthday': birthday});
  }

  Future<void> updateImage({required image}) {
    return users.doc(user!.uid).update({'image': image});
  }
}

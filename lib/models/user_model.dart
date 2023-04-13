// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  UserModel({
    this.name,
    this.image,
  });

  final String? name;
  final String? image;

  UserModel.fromJson(Map<String, Object?> json)
      : this(
          name: json['name'] == null ? null : json['name']! as String,
          image: json['image'] == null ? null : json['image']! as String,
        );

  Map<String, Object?> toJson() {
    return {
      'name': name,
      'image': image,
    };
  }
}

User? user = FirebaseAuth.instance.currentUser;
userQuery() {
  return FirebaseFirestore.instance
      .collection('users')
      .where('uid', isEqualTo: user!.uid)
      .withConverter<UserModel>(
          fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
          toFirestore: (usermodel, _) => usermodel.toJson());
}

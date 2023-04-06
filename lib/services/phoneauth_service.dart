import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceapp/screens/login/otp_screen.dart';
import 'package:ecommerceapp/screens/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../screens/login/login_screen.dart';

class PhoneAuthService {
  FirebaseAuth auth = FirebaseAuth.instance;

  User? user = FirebaseAuth.instance.currentUser;

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> addUser(context) {
    // final QuerySnapshot result =
    //     await users.where('uid', isEqualTo: user?.uid).get();

    // List<DocumentSnapshot> document = result.docs;

    // if (document.length > 0) {
    //   Navigator.pushReplacementNamed(context, MainScreen.id);
    // } else {

    // }
    return users.add({
      'uid': user!.uid,
      'mobile': user!.phoneNumber,
      'email': user!.email
    }).then((value) {
      Navigator.pushReplacementNamed(context, MainScreen.id);
    }).catchError((error) => print('Failed to add user: $error'));
  }

  Future<void> verifyPhoneNumber(BuildContext context, number) async {
    await auth.verifyPhoneNumber(
      phoneNumber: number,
      verificationCompleted: (PhoneAuthCredential credential) async {},
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) {
        LoginScreen.verify = verificationId;
        Navigator.pushNamed(context, OTPScreen.id);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }
}

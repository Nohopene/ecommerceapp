import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceapp/models/user_model.dart';
import 'package:ecommerceapp/screens/login/otp_screen.dart';
import 'package:ecommerceapp/screens/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../screens/login/login_screen.dart';

class PhoneAuthService {
  String? _uid;
  String get uid => _uid!;

  FirebaseAuth auth = FirebaseAuth.instance;

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

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

  void verifyOtp(
      {required String userOtp, required BuildContext context}) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: LoginScreen.verify, smsCode: userOtp);
      final User? user = (await auth.signInWithCredential(credential)).user;
      if (user != null) {
        _uid = user.uid;
        checkExistingUser(context: context);
      } else {
        print('Login failed');
      }
    } catch (e) {
      print('Wrong otp');
    }
  }

  Future<void> checkExistingUser({
    required BuildContext context,
  }) async {
    DocumentSnapshot snapshot =
        await _firebaseFirestore.collection("users").doc(_uid).get();
    if (snapshot.exists) {
      Navigator.pushReplacementNamed(context, MainScreen.id);
    } else {
      try {
        return _firebaseFirestore.collection("users").doc(_uid).set({
          'uid': auth.currentUser!.uid,
          'name': null,
          'phone': auth.currentUser!.phoneNumber,
          'email': auth.currentUser!.email,
          'birthday': null,
          'bio': null,
          'image': null
        }).then((value) {
          Navigator.pushReplacementNamed(context, MainScreen.id);
        });
      } on FirebaseAuthException catch (e) {
        showSnackBar(context, e.message.toString());
      }
    }
  }

  // Future<UserModel> getUser() async {
  //   final snapshot = await _firebaseFirestore
  //       .collection('Users')
  //       .where('uid', isEqualTo: _uid)
  //       .get();
  // }
}

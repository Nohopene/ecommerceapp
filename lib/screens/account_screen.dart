import 'package:ecommerceapp/screens/onboarding_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [],
        ),
        bottomSheet: SizedBox(
          height: 70,
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 1.5.h),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                OutlinedButton(
                  onPressed: () {
                    auth.signOut();
                    Navigator.pushNamed(context, OnboardingScreen.id);
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 17.h),
                    child: const Text(
                      'Logout',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Text(
                  'Peachy v 1.0.0',
                  style: TextStyle(color: Colors.grey.shade700, fontSize: 10),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../services/user_service.dart';
import '../../../widget/circle_icon_button.dart';

class ReBioWidget extends StatefulWidget {
  static const String id = 'rebio-screen';
  const ReBioWidget({super.key});

  @override
  State<ReBioWidget> createState() => _ReBioWidgetState();
}

class _ReBioWidgetState extends State<ReBioWidget> {
  final TextEditingController bioController = TextEditingController();
  User? user = FirebaseAuth.instance.currentUser;
  UserService _service = UserService();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: header(),
      body: StreamBuilder<QuerySnapshot>(
          stream: _service.users.where('uid', isEqualTo: user!.uid).snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: TextField(
                    controller: bioController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                );
              }).toList(),
            );
          }),
    ));
  }

  PreferredSize header() {
    return PreferredSize(
      preferredSize: Size.fromHeight(6.h),
      child: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        flexibleSpace: Padding(
          padding: EdgeInsets.symmetric(horizontal: 1.5.h, vertical: 1.h),
          child: Row(
            children: [
              CircleIconButton(
                size: 14,
                svgIcon: 'assets/icons/cancel.svg',
                color: const Color(0xFFF5F6F9),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              const SizedBox(
                width: 10,
              ),
              const Text(
                'Update bio',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
              ),
              const Spacer(),
              TextButton(
                  onPressed: () {
                    _service
                        .updateBio(bio: bioController.text)
                        .then((value) => Navigator.pop(context));
                  },
                  child: const Text('Save'))
            ],
          ),
        ),
      ),
    );
  }
}

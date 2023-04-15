import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceapp/screens/profile/widget/rebio_widget.dart';
import 'package:ecommerceapp/screens/profile/widget/rename_widget.dart';
import 'package:ecommerceapp/services/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../widget/circle_icon_button.dart';
import '../account/widget/header_widget.dart';

class ProfileScreen extends StatefulWidget {
  static const String id = 'profile-screen';
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  UserService _service = UserService();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: header(),
        body: StreamBuilder<QuerySnapshot>(
            stream:
                _service.users.where('uid', isEqualTo: user!.uid).snapshots(),
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

                  return Column(
                    children: [
                      HeaderProfileWidget(
                        height: 20.h,
                        heightAva: 9.h,
                        widthAva: 18.w,
                        size: 1.2.h,
                      ),
                      EditProfileWidget(
                        title: 'Name',
                        onpress: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      RenameWidget(
                                        name: data['name'],
                                      )));
                        },
                        value: data['name'] == '' ? 'Edit now' : data['name'],
                      ),
                      const Divider(
                        height: 1,
                      ),
                      EditProfileWidget(
                        title: 'Bio',
                        onpress: () {
                          Navigator.pushNamed(context, ReBioWidget.id);
                        },
                        value: data['bio'] == '' ? 'Edit now' : data['bio'],
                      ),
                      const Divider(
                        height: 1,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Divider(
                        height: 1,
                      ),
                      EditProfileWidget(
                        title: 'Gender',
                        onpress: () {},
                        value:
                            data['gender'] == '' ? 'Edit now' : data['gender'],
                      ),
                      const Divider(
                        height: 1,
                      ),
                      EditProfileWidget(
                        title: 'Birthday',
                        onpress: () {},
                        value: data['birthday'] == ''
                            ? 'Edit now'
                            : data['birthday'],
                      ),
                    ],
                  );
                }).toList(),
              );
            }),
      ),
    );
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
              const Spacer(),
              const Text(
                'Profile',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

class EditProfileWidget extends StatelessWidget {
  const EditProfileWidget({
    super.key,
    required this.title,
    required this.onpress,
    required this.value,
  });
  final String title, value;
  final VoidCallback onpress;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onpress,
      child: Container(
        height: 50,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 16,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    value,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey.shade600,
                    size: 16,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

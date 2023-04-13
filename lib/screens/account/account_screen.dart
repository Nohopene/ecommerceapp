import 'package:ecommerceapp/screens/account/widget/custom_listtitle.dart';
import 'package:ecommerceapp/screens/account/widget/header_widget.dart';
import 'package:ecommerceapp/screens/onboarding_screen.dart';
import 'package:ecommerceapp/screens/order/order_sceen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../constanst/color_constant.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const HeaderProfileWidget(),
            _buildProfileMenuButton(
              text: 'Edit profile',
              icon: 'assets/icons/User.svg',
              onPressed: () {
                Navigator.pushNamed(context, OrderScreen.id);
              },
            ),
            _buildProfileMenuButton(
              text: 'My orders',
              icon: 'assets/icons/order.svg',
              onPressed: () {},
            ),
            _buildProfileMenuButton(
              text: 'Delivery address',
              icon: 'assets/icons/location.svg',
              onPressed: () {},
            ),
          ],
        ),
        bottomSheet: _bottomWidget(auth, context),
      ),
    );
  }

  _buildProfileMenuButton({
    required String text,
    required String icon,
    required Function() onPressed,
  }) {
    return CustomListTile(
      leading: SvgPicture.asset(
        icon,
        color: primaryColor,
        width: 20,
      ),
      title: text,
      onPressed: onPressed,
      trailing: const Icon(
        Icons.arrow_forward_ios,
        color: textColor,
        size: 20,
      ),
    );
  }

  SizedBox _bottomWidget(FirebaseAuth auth, BuildContext context) {
    return SizedBox(
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
    );
  }
}

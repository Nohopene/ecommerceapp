
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class LoginWithButton extends StatelessWidget {
  final String myIcon;
  final title;

  final Function()? onTap;
  const LoginWithButton({
    super.key,
    required this.myIcon,
    this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: OutlinedButton(
        onPressed: onTap,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Row(
            children: [
              Image.asset(
                myIcon,
                height: 20,
                width: 20,
              ),
              SizedBox(width: 10.h),
              Text(
                title,
                style: const TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:ecommerceapp/constanst/color_constant.dart';
import 'package:ecommerceapp/constanst/image_constant.dart';
import 'package:ecommerceapp/screens/login/widget/button_widget.dart';

import 'package:ecommerceapp/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login-screen';

  const LoginScreen({super.key});

  static String verify = '';
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _validPhoneNumber = false;

  var countryCodeController = TextEditingController(text: '+84');

  var phoneNumberController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  showAlertDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          CircularProgressIndicator(),
          SizedBox(
            width: 5,
          ),
          Text('Please wait...')
        ],
      ),
    );
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }

  PhoneAuthService _service = PhoneAuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Container(
                  color: primaryColor,
                  height: 32.h,
                  width: double.infinity,
                  child: Column(children: [
                    SizedBox(height: 10.h),
                    Image.asset(
                      APP_LOGO,
                      width: double.infinity,
                      height: 12.h,
                    ),
                    SizedBox(height: 2.h),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const [
                              Text(
                                'Enter your phone number to process',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Roboto',
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const [
                              Text(
                                'Phone number using to login or create account',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ]),
                ),
                SizedBox(height: 6.h),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    controller: phoneNumberController,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(10),
                    ],
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12)),
                      ),
                      fillColor: Colors.grey.shade200,
                      filled: true,
                      hintText: 'Phone Number',
                    ),
                    onChanged: (value) {
                      setState(() {
                        if (value.length >= 9) {
                          _validPhoneNumber = true;
                        } else {
                          _validPhoneNumber = false;
                        }
                      });
                    },
                  ),
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: AbsorbPointer(
                        absorbing: _validPhoneNumber ? false : true,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: _validPhoneNumber
                                  ? primaryColor
                                  : Colors.grey),
                          onPressed: () {
                            showAlertDialog(context);
                            String number =
                                '${countryCodeController.text}${phoneNumberController.text}';
                            _service.verifyPhoneNumber(context, number);
                          },
                          child: const Padding(
                            padding: EdgeInsets.fromLTRB(122, 15, 122, 15),
                            child: Text(
                              'Continue',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 4.h),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[500],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'OR',
                          style: TextStyle(color: textColor),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 1.h),
                LoginWithButton(
                  title: 'Login with Google',
                  myIcon: 'assets/images/google.png',
                  onTap: () {},
                ),
                SizedBox(height: 1.h),
                LoginWithButton(
                  title: 'Login with Facebook',
                  myIcon: 'assets/images/facebook.png',
                  onTap: () {},
                ),
                SizedBox(height: 1.h),
              ],
            ),
          ),
        ));
  }
}

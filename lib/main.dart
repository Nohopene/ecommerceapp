import 'package:ecommerceapp/providers/cart_provider.dart';
import 'package:ecommerceapp/screens/cart/cart_screen.dart';
import 'package:ecommerceapp/screens/login/otp_screen.dart';
import 'package:ecommerceapp/screens/main_screen.dart';
import 'package:ecommerceapp/screens/login/login_screen.dart';
import 'package:ecommerceapp/screens/onboarding_screen.dart';
import 'package:ecommerceapp/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => CartProvider())],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: SplashScreen.id,
          routes: {
            SplashScreen.id: (context) => const SplashScreen(),
            OnboardingScreen.id: (context) => const OnboardingScreen(),
            LoginScreen.id: (context) => const LoginScreen(),
            MainScreen.id: (context) => const MainScreen(),
            OTPScreen.id: (context) => const OTPScreen(),
            CartScreen.id: (context) => const CartScreen()
          },
        );
      },
    );
  }
}

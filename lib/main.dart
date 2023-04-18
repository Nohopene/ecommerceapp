import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'package:ecommerceapp/providers/cart_provider.dart';
import 'package:ecommerceapp/providers/location_provider.dart';
import 'package:ecommerceapp/screens/cart/cart_screen.dart';
import 'package:ecommerceapp/screens/deliveryaddress/deliveyaddress_screen.dart';
import 'package:ecommerceapp/screens/deliveryaddress/widget/add_address.dart';
import 'package:ecommerceapp/screens/deliveryaddress/widget/googlemap_widget.dart';
import 'package:ecommerceapp/screens/login/login_screen.dart';
import 'package:ecommerceapp/screens/login/otp_screen.dart';
import 'package:ecommerceapp/screens/main_screen.dart';
import 'package:ecommerceapp/screens/onboarding_screen.dart';
import 'package:ecommerceapp/screens/order/order_sceen.dart';
import 'package:ecommerceapp/screens/profile/profile_screen.dart';
import 'package:ecommerceapp/screens/profile/widget/rebio_widget.dart';
import 'package:ecommerceapp/screens/profile/widget/rename_widget.dart';
import 'package:ecommerceapp/screens/splash_screen.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => CartProvider()),
      ChangeNotifierProvider(create: (_) => LocationProvider()),
    ],
    child: const MyApp(),
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
          initialRoute: MainScreen.id,
          builder: EasyLoading.init(),
          routes: {
            SplashScreen.id: (context) => const SplashScreen(),
            OnboardingScreen.id: (context) => const OnboardingScreen(),
            LoginScreen.id: (context) => const LoginScreen(),
            MainScreen.id: (context) => const MainScreen(),
            OTPScreen.id: (context) => const OTPScreen(),
            CartScreen.id: (context) => const CartScreen(),
            OrderScreen.id: (context) => const OrderScreen(),
            AddressScreen.id: (context) => const AddressScreen(),
            ProfileScreen.id: (context) => const ProfileScreen(),
            RenameWidget.id: (context) => const RenameWidget(),
            ReBioWidget.id: (context) => const ReBioWidget(),
            CurrentLocationScreenState.id: (context) =>
                const CurrentLocationScreenState(),
            AddAddressScreen.id: (context) => const AddAddressScreen(),
          },
        );
      },
    );
  }
}

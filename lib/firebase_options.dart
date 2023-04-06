// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCHeD-pdecAcw6_dpxr28_7HbhPR319IS8',
    appId: '1:987392032114:web:976bb8a6f390bff046b1eb',
    messagingSenderId: '987392032114',
    projectId: 'ecommerce-8ab32',
    authDomain: 'ecommerce-8ab32.firebaseapp.com',
    storageBucket: 'ecommerce-8ab32.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCmUQ6GCHMvhsQo_wPgkJkZJ0KC0-MVE3s',
    appId: '1:987392032114:android:0cc2d428c1f325ec46b1eb',
    messagingSenderId: '987392032114',
    projectId: 'ecommerce-8ab32',
    storageBucket: 'ecommerce-8ab32.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCW1iSGVNhVPw6b7-HL4gcEKS6IA55L1fY',
    appId: '1:987392032114:ios:edf246edaa151eeb46b1eb',
    messagingSenderId: '987392032114',
    projectId: 'ecommerce-8ab32',
    storageBucket: 'ecommerce-8ab32.appspot.com',
    iosClientId: '987392032114-pg03oav7g8sgn18uqs2oou5djb5gk4dc.apps.googleusercontent.com',
    iosBundleId: 'com.example.ecommerceapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCW1iSGVNhVPw6b7-HL4gcEKS6IA55L1fY',
    appId: '1:987392032114:ios:edf246edaa151eeb46b1eb',
    messagingSenderId: '987392032114',
    projectId: 'ecommerce-8ab32',
    storageBucket: 'ecommerce-8ab32.appspot.com',
    iosClientId: '987392032114-pg03oav7g8sgn18uqs2oou5djb5gk4dc.apps.googleusercontent.com',
    iosBundleId: 'com.example.ecommerceapp',
  );
}

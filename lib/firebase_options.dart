// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
// ignore: depend_on_referenced_packages
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
    apiKey: 'AIzaSyBicMPfoNZeyx9RcJOENOdG7eK2-ms0C98',
    appId: '1:802695093003:web:22f421cec03532d6d7600e',
    messagingSenderId: '802695093003',
    projectId: 'electric-21f3d',
    authDomain: 'electric-21f3d.firebaseapp.com',
    storageBucket: 'electric-21f3d.appspot.com',
    measurementId: 'G-9QQDRERCFF',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBAZnZiKtLT_mLgFziiHA8AFc643ZWMNhs',
    appId: '1:802695093003:android:ca0dabccb624f3c5d7600e',
    messagingSenderId: '802695093003',
    projectId: 'electric-21f3d',
    storageBucket: 'electric-21f3d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAsBViiiQLP8xTAPn9pWBUHC33TSH8x748',
    appId: '1:802695093003:ios:2760a38ffc1c1251d7600e',
    messagingSenderId: '802695093003',
    projectId: 'electric-21f3d',
    storageBucket: 'electric-21f3d.appspot.com',
    iosClientId:
        '802695093003-rbp4kich9ncf1vubqm97hqojqddn758g.apps.googleusercontent.com',
    iosBundleId: 'com.example.testChart',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAsBViiiQLP8xTAPn9pWBUHC33TSH8x748',
    appId: '1:802695093003:ios:2760a38ffc1c1251d7600e',
    messagingSenderId: '802695093003',
    projectId: 'electric-21f3d',
    storageBucket: 'electric-21f3d.appspot.com',
    iosClientId:
        '802695093003-rbp4kich9ncf1vubqm97hqojqddn758g.apps.googleusercontent.com',
    iosBundleId: 'com.example.testChart',
  );
}

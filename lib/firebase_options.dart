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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyAOKFBXoF7Ba0wwbjwZvVbuToVEiHwvyaU',
    appId: '1:1030355093795:web:8c313a5fa9e8f6314f2496',
    messagingSenderId: '1030355093795',
    projectId: 'expense-tracker-1111',
    authDomain: 'expense-tracker-1111.firebaseapp.com',
    databaseURL: 'https://expense-tracker-1111-default-rtdb.firebaseio.com',
    storageBucket: 'expense-tracker-1111.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCl_bx-azNDM1S308D2YBIDKGzhrt5dLvQ',
    appId: '1:1030355093795:android:002c53b989b417a74f2496',
    messagingSenderId: '1030355093795',
    projectId: 'expense-tracker-1111',
    databaseURL: 'https://expense-tracker-1111-default-rtdb.firebaseio.com',
    storageBucket: 'expense-tracker-1111.appspot.com',
  );
}

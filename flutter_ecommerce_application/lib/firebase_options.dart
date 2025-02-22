// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyB5m-UGQnVCt81PTqiEh7Zu946PU8Ns-9o',
    appId: '1:123761306993:web:7d43a00e9f9d69bf1b5ad0',
    messagingSenderId: '123761306993',
    projectId: 'e-comhub',
    authDomain: 'e-comhub.firebaseapp.com',
    storageBucket: 'e-comhub.firebasestorage.app',
    measurementId: 'G-9NTHSXEJSB',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDdzDZpOpKsxiexoEOCtRkKbkbxIwoPQto',
    appId: '1:123761306993:android:fd5993413d4b05c01b5ad0',
    messagingSenderId: '123761306993',
    projectId: 'e-comhub',
    storageBucket: 'e-comhub.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCowgH7qlzS6ql10oQ3P5mUm9GyncH5sEE',
    appId: '1:123761306993:ios:eab9d6d952f9e3151b5ad0',
    messagingSenderId: '123761306993',
    projectId: 'e-comhub',
    storageBucket: 'e-comhub.firebasestorage.app',
    iosBundleId: 'com.example.flutterEcommerceApplication',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCowgH7qlzS6ql10oQ3P5mUm9GyncH5sEE',
    appId: '1:123761306993:ios:eab9d6d952f9e3151b5ad0',
    messagingSenderId: '123761306993',
    projectId: 'e-comhub',
    storageBucket: 'e-comhub.firebasestorage.app',
    iosBundleId: 'com.example.flutterEcommerceApplication',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyB5m-UGQnVCt81PTqiEh7Zu946PU8Ns-9o',
    appId: '1:123761306993:web:1853027606851a361b5ad0',
    messagingSenderId: '123761306993',
    projectId: 'e-comhub',
    authDomain: 'e-comhub.firebaseapp.com',
    storageBucket: 'e-comhub.firebasestorage.app',
    measurementId: 'G-8ZPDS1TYLF',
  );
}

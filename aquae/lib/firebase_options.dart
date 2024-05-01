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
    apiKey: 'AIzaSyAmP6Jf6frEgUheyI1IgXDHTinHRx_nCgk',
    appId: '1:55235979861:web:5c6b4d6f6c3271377742dc',
    messagingSenderId: '55235979861',
    projectId: 'aquae-5fddb',
    authDomain: 'aquae-5fddb.firebaseapp.com',
    storageBucket: 'aquae-5fddb.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAQekvIz5QOOeNfXdESV799sJ57l_QV4tU',
    appId: '1:55235979861:android:81fe72dbf4d0feb97742dc',
    messagingSenderId: '55235979861',
    projectId: 'aquae-5fddb',
    storageBucket: 'aquae-5fddb.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAu7LtPtXaa-IMF7E8NAbpXjSoHpEaGciA',
    appId: '1:55235979861:ios:3031f5e590f9df6d7742dc',
    messagingSenderId: '55235979861',
    projectId: 'aquae-5fddb',
    storageBucket: 'aquae-5fddb.appspot.com',
    iosBundleId: 'com.example.aquae',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAu7LtPtXaa-IMF7E8NAbpXjSoHpEaGciA',
    appId: '1:55235979861:ios:3031f5e590f9df6d7742dc',
    messagingSenderId: '55235979861',
    projectId: 'aquae-5fddb',
    storageBucket: 'aquae-5fddb.appspot.com',
    iosBundleId: 'com.example.aquae',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAmP6Jf6frEgUheyI1IgXDHTinHRx_nCgk',
    appId: '1:55235979861:web:6ab61e91309a739d7742dc',
    messagingSenderId: '55235979861',
    projectId: 'aquae-5fddb',
    authDomain: 'aquae-5fddb.firebaseapp.com',
    storageBucket: 'aquae-5fddb.appspot.com',
  );
}

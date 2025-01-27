
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
    apiKey: 'AIzaSyC8odhJvf2zyuKW-HeTCAbEuaVdMqlQP4A',
    appId: '1:798524512607:web:cbbe8f78055419cd9dfeea',
    messagingSenderId: '798524512607',
    projectId: 'movieapp-5d5e0',
    authDomain: 'movieapp-5d5e0.firebaseapp.com',
    storageBucket: 'movieapp-5d5e0.appspot.com',
    measurementId: 'G-NY5ZJYKVH2',
    databaseURL: 'https://movieapp-5d5e0-default-rtdb.firebaseio.com'
  );
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCAo5S6Qz9rx2p6JVosMYPZyhC3yCF2PW0',
    appId: '1:798524512607:android:01f61466273fe9769dfeea',
    messagingSenderId: '798524512607',
    projectId: 'movieapp-5d5e0',
    storageBucket: 'movieapp-5d5e0.appspot.com',
  );
  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAYBeb7gFANQab4e1M6vGndq-PDESCKjww',
    appId: '1:798524512607:ios:a2dcb81cd0e460129dfeea',
    messagingSenderId: '798524512607',
    projectId: 'movieapp-5d5e0',
    storageBucket: 'movieapp-5d5e0.appspot.com',
    iosBundleId: 'com.example.movieapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAYBeb7gFANQab4e1M6vGndq-PDESCKjww',
    appId: '1:798524512607:ios:a2dcb81cd0e460129dfeea',
    messagingSenderId: '798524512607',
    projectId: 'movieapp-5d5e0',
    storageBucket: 'movieapp-5d5e0.appspot.com',
    iosBundleId: 'com.example.movieapp',
  );
  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyC8odhJvf2zyuKW-HeTCAbEuaVdMqlQP4A',
    appId: '1:798524512607:web:fe908e67c5122a179dfeea',
    messagingSenderId: '798524512607',
    projectId: 'movieapp-5d5e0',
    authDomain: 'movieapp-5d5e0.firebaseapp.com',
    storageBucket: 'movieapp-5d5e0.appspot.com',
    measurementId: 'G-YECZPKRNXJ',
  );
}
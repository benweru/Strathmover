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
    apiKey: 'AIzaSyDS_2KmRHX2qsBp7rjK1S9u_p2FdqC675k',
    appId: '1:493256316498:web:4e6dcdd75ff5ecc197318b',
    messagingSenderId: '493256316498',
    projectId: 'strathmover',
    authDomain: 'strathmover.firebaseapp.com',
    storageBucket: 'strathmover.appspot.com',
    measurementId: 'G-FR83NBHBKJ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAZ6D6SfsdSYNhu57xZgrnmWI8jH0jTnjM',
    appId: '1:493256316498:android:40b142f4fae47ae697318b',
    messagingSenderId: '493256316498',
    projectId: 'strathmover',
    storageBucket: 'strathmover.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDWf7NsA1n2U3nTlWhxbb1xGrkelaMIdvM',
    appId: '1:493256316498:ios:9382f6344456562e97318b',
    messagingSenderId: '493256316498',
    projectId: 'strathmover',
    storageBucket: 'strathmover.appspot.com',
    androidClientId: '493256316498-vphbrubijr40r3ltt1pmsvq98jour4ar.apps.googleusercontent.com',
    iosClientId: '493256316498-k5b7v9fjn0406427jn1oajk1fphoqfkt.apps.googleusercontent.com',
    iosBundleId: 'com.example.sampleflutt',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDWf7NsA1n2U3nTlWhxbb1xGrkelaMIdvM',
    appId: '1:493256316498:ios:9382f6344456562e97318b',
    messagingSenderId: '493256316498',
    projectId: 'strathmover',
    storageBucket: 'strathmover.appspot.com',
    androidClientId: '493256316498-vphbrubijr40r3ltt1pmsvq98jour4ar.apps.googleusercontent.com',
    iosClientId: '493256316498-k5b7v9fjn0406427jn1oajk1fphoqfkt.apps.googleusercontent.com',
    iosBundleId: 'com.example.sampleflutt',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDS_2KmRHX2qsBp7rjK1S9u_p2FdqC675k',
    appId: '1:493256316498:web:7c3fb1daa7ba252797318b',
    messagingSenderId: '493256316498',
    projectId: 'strathmover',
    authDomain: 'strathmover.firebaseapp.com',
    storageBucket: 'strathmover.appspot.com',
    measurementId: 'G-ZRBR8T9K9N',
  );
}
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
    apiKey: 'AIzaSyBk7fL8D9x5s6-cRdFWL8h2nFFWXIIlcaE',
    appId: '1:660748519011:web:a6bd6134cfa30bf1035a56',
    messagingSenderId: '660748519011',
    projectId: 'my-cool-project-45922',
    authDomain: 'my-cool-project-45922.firebaseapp.com',
    storageBucket: 'my-cool-project-45922.firebasestorage.app',
    measurementId: 'G-D1KL5QT6NM',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAF_Ko4gzHKtrY7UHd9aGGykQxHE1oMYB8',
    appId: '1:660748519011:android:e0b6c648e4a9180a035a56',
    messagingSenderId: '660748519011',
    projectId: 'my-cool-project-45922',
    storageBucket: 'my-cool-project-45922.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBfQZP55wKcuGreFqUtGFrdra_dryGQD8g',
    appId: '1:660748519011:ios:881ad565bb585969035a56',
    messagingSenderId: '660748519011',
    projectId: 'my-cool-project-45922',
    storageBucket: 'my-cool-project-45922.firebasestorage.app',
    iosClientId: '660748519011-vl3oi3r8atmg7n7pkjq61rokqemc0vfs.apps.googleusercontent.com',
    iosBundleId: 'com.example.advancedDiaryApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBfQZP55wKcuGreFqUtGFrdra_dryGQD8g',
    appId: '1:660748519011:ios:881ad565bb585969035a56',
    messagingSenderId: '660748519011',
    projectId: 'my-cool-project-45922',
    storageBucket: 'my-cool-project-45922.firebasestorage.app',
    iosClientId: '660748519011-vl3oi3r8atmg7n7pkjq61rokqemc0vfs.apps.googleusercontent.com',
    iosBundleId: 'com.example.advancedDiaryApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBk7fL8D9x5s6-cRdFWL8h2nFFWXIIlcaE',
    appId: '1:660748519011:web:33d6fb963a691fa0035a56',
    messagingSenderId: '660748519011',
    projectId: 'my-cool-project-45922',
    authDomain: 'my-cool-project-45922.firebaseapp.com',
    storageBucket: 'my-cool-project-45922.firebasestorage.app',
    measurementId: 'G-72D27NTE8H',
  );

}
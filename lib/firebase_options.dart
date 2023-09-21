import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;
import 'package:flutter_dotenv/flutter_dotenv.dart';

final String apiKey = dotenv.env['FIREBASE_API_KEY'] ?? '';

FirebaseOptions getFirebaseOptions(String apiKey) {
  return FirebaseOptions(
    apiKey: apiKey,
    appId: '1:282776569513:android:6255ebd40f421da9bc4bb8',
    messagingSenderId: '282776569513',
    projectId: 'mynotes-flutter-zaki',
    storageBucket: 'mynotes-flutter-zaki.appspot.com',
  );
}

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
    apiKey: 'apiKey',
    appId: '1:282776569513:web:75af1ffef99837cabc4bb8',
    messagingSenderId: '282776569513',
    projectId: 'mynotes-flutter-zaki',
    authDomain: 'mynotes-flutter-zaki.firebaseapp.com',
    storageBucket: 'mynotes-flutter-zaki.appspot.com',
  );

  static FirebaseOptions android = FirebaseOptions(
    apiKey: apiKey,
    appId: '1:282776569513:android:6255ebd40f421da9bc4bb8',
    messagingSenderId: '282776569513',
    projectId: 'mynotes-flutter-zaki',
    storageBucket: 'mynotes-flutter-zaki.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'apiKey',
    appId: '1:282776569513:ios:48509a735164a189bc4bb8',
    messagingSenderId: '282776569513',
    projectId: 'mynotes-flutter-zaki',
    storageBucket: 'mynotes-flutter-zaki.appspot.com',
    iosClientId:
        '282776569513-54lmalbeljjh9ngt7h8evfjbpibiv22b.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterApplication1',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'apikey',
    appId: '1:282776569513:ios:48509a735164a189bc4bb8',
    messagingSenderId: '282776569513',
    projectId: 'mynotes-flutter-zaki',
    storageBucket: 'mynotes-flutter-zaki.appspot.com',
    iosClientId:
        '282776569513-54lmalbeljjh9ngt7h8evfjbpibiv22b.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterApplication1',
  );
}

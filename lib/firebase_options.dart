// // File generated by FlutterFire CLI.
// // ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
// import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
// import 'package:flutter/foundation.dart'
//     show defaultTargetPlatform, kIsWeb, TargetPlatform;

// /// Default [FirebaseOptions] for use with your Firebase apps.
// ///
// /// Example:
// /// ```dart
// /// import 'firebase_options.dart';
// /// // ...
// /// await Firebase.initializeApp(
// ///   options: DefaultFirebaseOptions.currentPlatform,
// /// );
// /// ```
// class DefaultFirebaseOptions {
//   static FirebaseOptions get currentPlatform {
//     if (kIsWeb) {
//       return web;
//     }
//     switch (defaultTargetPlatform) {
//       case TargetPlatform.android:
//         return android;
//       case TargetPlatform.iOS:
//         return ios;
//       case TargetPlatform.macOS:
//         return macos;
//       case TargetPlatform.windows:
//         throw UnsupportedError(
//           'DefaultFirebaseOptions have not been configured for windows - '
//           'you can reconfigure this by running the FlutterFire CLI again.',
//         );
//       case TargetPlatform.linux:
//         throw UnsupportedError(
//           'DefaultFirebaseOptions have not been configured for linux - '
//           'you can reconfigure this by running the FlutterFire CLI again.',
//         );
//       default:
//         throw UnsupportedError(
//           'DefaultFirebaseOptions are not supported for this platform.',
//         );
//     }
//   }

//   static const FirebaseOptions web = FirebaseOptions(
//     apiKey: 'AIzaSyBpene2UfOIDy4WVn5G9lMkxsPl1twRd70',
//     appId: '1:313416279537:web:095d63e8835f4d1607d050',
//     messagingSenderId: '313416279537',
//     projectId: 'notifyinsiit',
//     authDomain: 'notifyinsiit.firebaseapp.com',
//     storageBucket: 'notifyinsiit.appspot.com',
//     measurementId: 'G-R4HPEGHK08',
//   );

//   static const FirebaseOptions android = FirebaseOptions(
//     apiKey: 'AIzaSyBrRLbXc6_wV33akm2CeTkk7rLo6i4vxDU',
//     appId: '1:313416279537:android:f1a579cc5fa1a90f07d050',
//     messagingSenderId: '313416279537',
//     projectId: 'notifyinsiit',
//     storageBucket: 'notifyinsiit.appspot.com',
//   );

//   static const FirebaseOptions ios = FirebaseOptions(
//     apiKey: 'AIzaSyAmD5xyk42UiFdoSdtGwGhOomKs5ulmsZI',
//     appId: '1:313416279537:ios:1dd1ebf2cf45e04407d050',
//     messagingSenderId: '313416279537',
//     projectId: 'notifyinsiit',
//     storageBucket: 'notifyinsiit.appspot.com',
//     iosBundleId: 'com.example.insiit',
//   );

//   static const FirebaseOptions macos = FirebaseOptions(
//     apiKey: 'AIzaSyAmD5xyk42UiFdoSdtGwGhOomKs5ulmsZI',
//     appId: '1:313416279537:ios:58d4f86552ec728407d050',
//     messagingSenderId: '313416279537',
//     projectId: 'notifyinsiit',
//     storageBucket: 'notifyinsiit.appspot.com',
//     iosBundleId: 'com.example.insiit.RunnerTests',
//   );
// }
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
    apiKey: 'AIzaSyBGokF5YhxMwpHHzGsGpp3LHN1wWzFTmdE',
    appId: '1:127637978151:web:a99089972e11fd6caf6202',
    messagingSenderId: '127637978151',
    projectId: 'insiit-iitgn-2cd16',
    authDomain: 'insiit-iitgn-2cd16.firebaseapp.com',
    storageBucket: 'insiit-iitgn-2cd16.appspot.com',
    measurementId: 'G-6EZ23WKEE5',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDf4gRQNgPfKgHkvNsoqvIQbqdtwrIRsR4',
    appId: '1:127637978151:android:b16b7ec471f9e191af6202',
    messagingSenderId: '127637978151',
    projectId: 'insiit-iitgn-2cd16',
    storageBucket: 'insiit-iitgn-2cd16.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAvn77iwEsNZLllHR2HLhfGY4_n2Hz7CEo',
    appId: '1:127637978151:ios:cc42edcfcfdc5c6caf6202',
    messagingSenderId: '127637978151',
    projectId: 'insiit-iitgn-2cd16',
    storageBucket: 'insiit-iitgn-2cd16.appspot.com',
    iosClientId:
        '127637978151-fd2f8b9uj476pd418mngo4t5295g67la.apps.googleusercontent.com',
    iosBundleId: 'com.iitgn.insiit',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAvn77iwEsNZLllHR2HLhfGY4_n2Hz7CEo',
    appId: '1:127637978151:ios:cc42edcfcfdc5c6caf6202',
    messagingSenderId: '127637978151',
    projectId: 'insiit-iitgn-2cd16',
    storageBucket: 'insiit-iitgn-2cd16.appspot.com',
    iosClientId:
        '127637978151-fd2f8b9uj476pd418mngo4t5295g67la.apps.googleusercontent.com',
    iosBundleId: 'com.iitgn.insiit',
  );
}

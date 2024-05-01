import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_authentication_venkat/Screens/splashscreen.dart';

// Firebase Configation and Initialization(Android and Web)
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Connecting the Flutter project to Firebase
  Platform.isAndroid?
      await Firebase.initializeApp(
        options: const FirebaseOptions(
          apiKey:'AIzaSyDQ4agc4O0BIP0ZI9AyWp_To2_YvKSiZwA',
          appId:'1:17857744929:android:5e396711a755aa85711360',
          messagingSenderId:'17857744929',
          projectId:'fir-authentication-f83a7',
        ),
      ) : await Firebase.initializeApp();

  // await FirebaseAppCheck.instance.activate(
  //   //webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
  //   androidProvider: AndroidProvider.debug,
  //   //appleProvider: AppleProvider.appAttest,
  // );

  // if (kIsWeb) {
  //   await Firebase.initializeApp(
  //     options: FirebaseOptions(
  //         apiKey: "AIzaSyDH1goxLKeUEjmBPK0CaGDbF5C8ztPaUlU",
  //         appId: "1:957701581785:web:b5c178efe38a19887747c8",
  //         messagingSenderId: "957701581785",
  //         projectId: "flutter-firebase-venkat"),
  //   );
  // }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: SplashScreen(),
    );
  }
}
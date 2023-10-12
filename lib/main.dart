import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reserveabite/Screens/signin_screen.dart';
import 'package:reserveabite/Screens/signup_screen.dart';
import 'package:reserveabite/splash_screen.dart';
import 'Screens/home_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    theme: ThemeData(
      primaryColor: const Color(0xff1034A6),

    ),

    initialRoute: '/',

    routes: {
      '/':(context) => const SplashScreen (),
      'HomeScreen':(context) => HomeScreen (),
      'SignUpScreen':(context) => SignUpScreen (),
      'SignInScreen':(context) => SignInScreen (),

    },
  ));
}
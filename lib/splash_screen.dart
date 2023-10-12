import 'package:flutter/material.dart';
import 'package:reserveabite/Screens/signin_screen.dart';
import 'dart:async';

import 'Firebase Services/splash_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double opacity = 0.0;
  SplashServices splashServices = SplashServices();
  @override
  void initState() {
    super.initState();
    // Start the animation after a delay
    Timer(Duration(seconds: 1), () {
      setState(() {
        opacity = 1.0; // Set opacity to 1 to make the widget fade in
      });
    });

    // Add a delay before navigating to the main screen
    Timer(Duration(seconds: 4), () {
      // Navigate to the main screen after the delay
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => SignInScreen(),
      ));
    });
    splashServices.isLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // You can customize the splash screen UI here
      body: Center(
        child: AnimatedOpacity(
          duration: Duration(seconds: 2), // Duration of the animation
          opacity: opacity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Add your logo or any other splash screen content here
              Image.asset(
                'assets/Logo.png',
                height: 200,
                width: 200,
              ),
              SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }
}

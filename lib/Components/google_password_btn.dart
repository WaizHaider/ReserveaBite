import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GoogleLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height*0.08,
      width: MediaQuery.of(context).size.width * 0.7,
      child: ElevatedButton.icon(
        onPressed: () {
          // Add your Google login logic here
        },
        icon: Image.asset(
          'assets/google_logo.png', // Replace with your Google logo asset
          height: 24.0,
          width: 24.0,
        ),
        label: Text(
          'Login with Google',
          style: GoogleFonts.openSans(
            fontSize: 18.0,
            fontWeight: FontWeight.bold
          ),
        ),
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
          onPrimary: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22.0),
          ),
          //padding: EdgeInsets.symmetric(vertical: 12.0,), // Adjust the padding here
        ),
      ),
    );
  }
}


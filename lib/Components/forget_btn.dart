import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height*0.07,
      width: MediaQuery.of(context).size.width * 0.7,
      child: ElevatedButton.icon(
        onPressed: () {
          // Add your Google login logic here
        },
        icon: Image.asset(
          'assets/Logo.png', // Replace with your Google logo asset
          height: 32.0,
          width: 32.0,
        ),
        label: Text(
          'Send Email',
          style: GoogleFonts.openSans(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
          onPrimary: Color(0xFFED6E1B),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22.0),
          ),
          //padding: EdgeInsets.symmetric(vertical: 12.0,), // Adjust the padding here
        ),
      ),
    );
  }
}


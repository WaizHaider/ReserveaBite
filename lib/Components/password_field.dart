import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PasswordField extends StatefulWidget {
  final TextEditingController passwordController;

  PasswordField({required this.passwordController});

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool isPasswordVisible = false;

  void togglePasswordVisibility() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      width: MediaQuery.of(context).size.width * 0.75,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(22.0),
        ),
        color: Colors.blue,
      ),
      child: TextFormField(
        controller: widget.passwordController,
        obscureText: !isPasswordVisible,
        style: GoogleFonts.abel(
          color: Colors.white,
          fontSize: 16,
        ),
        decoration: InputDecoration(
          labelText: "Password",
          labelStyle: GoogleFonts.abel(
            color: Colors.white,
            fontSize: 20,
          ),
          hintText: "Enter your password",
          hintStyle: GoogleFonts.abel(
            color: Colors.white70,
            fontSize: 14,
          ),
          prefixIcon: Icon(
            Icons.lock,
            color: Colors.white,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              isPasswordVisible ? Icons.visibility : Icons.visibility_off,
              color: Colors.white,
            ),
            onPressed: togglePasswordVisibility,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 15.0,
          ),
          // Customize the text cursor color
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white), // Cursor color
          ),
        ),
        cursorColor: Colors.white, // Set the text cursor color
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please enter your password";
          }
          return null;
        },
      ),
    );
  }
}

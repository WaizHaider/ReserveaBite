import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpButton extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController userNameController;
  final TextEditingController phoneController;
  final TextEditingController passwordController;

  SignUpButton({
    required this.emailController,
    required this.userNameController,
    required this.phoneController,
    required this.passwordController,
  });

  void _createUserRecord() async {
    try {
      final firestore = FirebaseFirestore.instance;

      // Create a new user document with a unique ID
      await firestore.collection('users').add({
        'email': emailController.text,
        'username': userNameController.text,
        'phone': phoneController.text,
        // Add other user data fields as needed
      });

      // Display a success message or navigate to another screen
      // after successfully creating the user record.
      print('User record created successfully');
    } catch (e) {
      // Handle any errors that occur during the process.
      print('Error creating user record: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Validate user input and create a user record in Firestore
        if (validateUserData()) {
          _createUserRecord();
        }
      },
      child: Text('Sign Up',style: GoogleFonts.abel(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white),),
    );
  }

  // Add a validation method to check user input before creating a record
  bool validateUserData() {
    // You can add your validation logic here
    if (emailController.text.isEmpty ||
        userNameController.text.isEmpty ||
        phoneController.text.isEmpty ||
        passwordController.text.isEmpty) {
      // Display an error message or show a dialog
      print('Please fill in all fields');
      return false;
    }
    // You can add more validation rules here as needed.
    return true;
  }
}

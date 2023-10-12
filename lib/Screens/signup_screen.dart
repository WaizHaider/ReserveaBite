import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reserveabite/Components/password_field.dart';
import 'package:reserveabite/Components/signup_btn.dart';

import 'home_screen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _database =
  FirebaseDatabase.instance.ref().child('Users'); // Replace 'users' with your Firebase Realtime Database reference

  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> signUpWithEmailAndPassword() async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // Generate a unique user ID
      String userId = userCredential.user!.uid;

      // Store user data in the Realtime Database
      await _database.child(userId).set({
        'userId': userId, // Include the user ID
        'userName': userNameController.text,
        'email': emailController.text,
        'phone': phoneController.text,
      });

      // After successful sign-up, navigate to the next screen (e.g., home screen)
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
    } catch (e) {
      // Handle sign-up errors
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    bool _obscureText = true;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFED6E1B),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                Positioned(
                  top: 0,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.19,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      color: Color(0xFFED6E1B),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50.0),
                        bottomRight: Radius.circular(50.0),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.sizeOf(context).height,
                  width: MediaQuery.sizeOf(context).width,
                ),
                Positioned(
                  top: MediaQuery.sizeOf(context).height * 0.04,
                  left: MediaQuery.sizeOf(context).height * 0.03,
                  child: Text(
                    "Sign Up",
                    style: GoogleFonts.abel(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                Positioned(
                  top: MediaQuery.sizeOf(context).height * 0.11,
                  child: Image.asset(
                    'assets/Logo.png',
                    height: MediaQuery.sizeOf(context).height * 0.2,
                    width: MediaQuery.sizeOf(context).width * 0.4,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.32,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    width: MediaQuery.of(context).size.width * 0.75,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                          Radius.circular(22.0)), // Adjust the radius as needed
                      color: Colors.blue, // Background color of the container
                    ),
                    child: TextFormField(
                      controller: userNameController,
                      style: GoogleFonts.openSans(
                        // Set Google Fonts for the input text color
                        color: Colors.white, // Input text color
                        fontSize: 16,
                      ),
                      decoration: InputDecoration(
                        labelText: "Full Name",
                        labelStyle: GoogleFonts.openSans(
                          // Use Google Fonts here
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        hintText: "Enter your name",
                        hintStyle: GoogleFonts.openSans(
                          // Use Google Fonts here
                          color: Colors.white70,
                          fontSize: 14,
                        ),

                        prefixIcon: Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                        border:
                        InputBorder.none, // Remove the default underline
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 20.0,
                            vertical: 15.0), // Adjust padding as needed
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your name";
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.43,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    width: MediaQuery.of(context).size.width * 0.75,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                          Radius.circular(22.0)), // Adjust the radius as needed
                      color: Colors.blue, // Background color of the container
                    ),
                    child: TextFormField(
                      controller: emailController,
                      style: GoogleFonts.openSans(
                        // Set Google Fonts for the input text color
                        color: Colors.white, // Input text color
                        fontSize: 16,
                      ),
                      decoration: InputDecoration(
                        labelText: "Email",
                        labelStyle: GoogleFonts.openSans(
                          // Use Google Fonts here
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        hintText: "Enter your email",
                        hintStyle: GoogleFonts.openSans(
                          // Use Google Fonts here
                          color: Colors.white70,
                          fontSize: 14,
                        ),

                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.white,
                        ),
                        border:
                        InputBorder.none, // Remove the default underline
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 20.0,
                            vertical: 15.0), // Adjust padding as needed
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your email";
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.54,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    width: MediaQuery.of(context).size.width * 0.75,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                          Radius.circular(22.0)), // Adjust the radius as needed
                      color: Colors.blue, // Background color of the container
                    ),
                    child: TextFormField(
                      controller: phoneController, // Create a TextEditingController for the phone number
                      keyboardType: TextInputType.phone, // Set the keyboard type to phone number
                      style: GoogleFonts.openSans(
                        // Set Google Fonts for the input text color
                        color: Colors.white, // Input text color
                        fontSize: 16,
                      ),
                      decoration: InputDecoration(
                        labelText: "Phone Number", // Change the label text
                        labelStyle: GoogleFonts.openSans(
                          // Use Google Fonts here
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        hintText: "Enter your phone number", // Change the hint text
                        hintStyle: GoogleFonts.openSans(
                          // Use Google Fonts here
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                        prefixIcon: Icon(
                          Icons.phone, // Change the prefix icon to a phone icon
                          color: Colors.white,
                        ),
                        border:
                        InputBorder.none, // Remove the default underline
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 20.0,
                            vertical: 15.0), // Adjust padding as needed
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your phone number";
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.65,
                  child: PasswordField(
                    passwordController: passwordController,
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.78,
                  child: ElevatedButton(
                    onPressed: signUpWithEmailAndPassword,
                    child: Text('Sign Up'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );

  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Components/password_field.dart';
import '../Screens/home_screen.dart';

class SubAdminScreen extends StatefulWidget {
  @override
  _SubAdminScreenState createState() => _SubAdminScreenState();
}

class _SubAdminScreenState extends State<SubAdminScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _database = FirebaseDatabase.instance.ref().child(
      'SubAdmin'); // Replace 'users' with your Firebase Realtime Database reference

  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController franchiseController = TextEditingController();

  Future<void> signUpWithEmailAndPassword() async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
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
        'password': passwordController.text,
        'franchise': franchiseController.text,
      });

      // After successful sign-up, navigate to the next screen (e.g., home screen)
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
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
                    decoration: BoxDecoration(
                      color: Color(0xFFED6E1B),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50.0),
                        bottomRight: Radius.circular(50.0),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.04,
                  left: MediaQuery.of(context).size.width * 0.03,
                  child: Text(
                    "Sign Up",
                    style: GoogleFonts.abel(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.11,
                  child: Image.asset(
                    'assets/Logo.png',
                    height: MediaQuery.of(context).size.height * 0.2,
                    width: MediaQuery.of(context).size.width * 0.4,
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
                        Radius.circular(22.0),
                      ),
                      color: Colors.blue,
                    ),
                    child: TextFormField(
                      controller: userNameController,
                      style: GoogleFonts.openSans(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                      decoration: InputDecoration(
                        labelText: "Full Name",
                        labelStyle: GoogleFonts.openSans(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        hintText: "Enter your name",
                        hintStyle: GoogleFonts.openSans(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                        prefixIcon: Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 15.0,
                        ),
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
                        Radius.circular(22.0),
                      ),
                      color: Colors.blue,
                    ),
                    child: TextFormField(
                      controller: emailController,
                      style: GoogleFonts.openSans(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                      decoration: InputDecoration(
                        labelText: "Email",
                        labelStyle: GoogleFonts.openSans(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        hintText: "Enter your email",
                        hintStyle: GoogleFonts.openSans(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.white,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 15.0,
                        ),
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
                        Radius.circular(22.0),
                      ),
                      color: Colors.blue,
                    ),
                    child: TextFormField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      style: GoogleFonts.openSans(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                      decoration: InputDecoration(
                        labelText: "Phone Number",
                        labelStyle: GoogleFonts.openSans(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        hintText: "Enter your phone number",
                        hintStyle: GoogleFonts.openSans(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                        prefixIcon: Icon(
                          Icons.phone,
                          color: Colors.white,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 15.0,
                        ),
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
                    top: MediaQuery.of(context).size.height * 0.75,
                    child: Container(
                        margin: EdgeInsets.symmetric(vertical: 8.0),
                        width: MediaQuery.of(context).size.width * 0.75,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(22.0),
                          ),
                          color: Colors.blue,
                        ),
                        child: TextFormField(
                            controller: franchiseController,
                            style: GoogleFonts.openSans(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                            decoration: InputDecoration(
                              labelText: "Franchise",
                              labelStyle: GoogleFonts.openSans(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                              hintText: "Enter franchise name",
                              hintStyle: GoogleFonts.openSans(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                              prefixIcon: Icon(
                                Icons.house_rounded,
                                color: Colors.white,
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 20.0,
                                vertical: 15.0,
                              ),
                        ),),),),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.88,
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

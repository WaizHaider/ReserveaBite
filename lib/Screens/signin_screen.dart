import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reserveabite/Components/google_password_btn.dart';
import 'package:reserveabite/Components/password_field.dart';
import 'package:reserveabite/Screens/forget_password.dart';
import 'package:reserveabite/Screens/signup_screen.dart';
import 'package:reserveabite/Temp/add_posts.dart';

import 'home_screen.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _database = FirebaseDatabase.instance.ref().child('Users');
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> signInWithEmailAndPassword(BuildContext context) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // Retrieve user data from the Users node based on the user's UID
      DataSnapshot snapshot = (await _database.child(userCredential.user!.uid).once()).snapshot;

      if (snapshot.value != null) {
        // User exists in the database, check if required fields exist
        final userData = snapshot.value as Map<dynamic, dynamic>;

        if (userData.containsKey('email') &&
            userData.containsKey('phone') &&
            userData.containsKey('userId') &&
            userData.containsKey('userName')) {
          // Required fields exist, navigate to the next screen (e.g., HomeScreen)
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
        } else {
          // Missing required fields
          print('Error: User data is incomplete');
        }
      } else {
        // User does not exist in the database
        print('Error: User not found in the database');
      }
    } catch (e) {
      // Handle authentication errors
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
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
                    "Sign In",
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
                  top: MediaQuery.of(context).size.height * 0.33,
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
                      style: GoogleFonts.abel(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                      decoration: InputDecoration(
                        labelText: "Email",
                        labelStyle: GoogleFonts.abel(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        hintText: "Enter your email",
                        hintStyle: GoogleFonts.abel(
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
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      cursorColor: Colors.white, // Set the text cursor color to white
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
                  top: MediaQuery.of(context).size.height * 0.44,
                  child: PasswordField(
                    passwordController: passwordController,
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.55,
                  right: MediaQuery.of(context).size.height * 0.08,
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgetPasswordScreen()));
                    },
                    child: Text(
                      'Forget Password',
                      style: GoogleFonts.openSans(
                        color: Color(0xFFED6E1B),
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.59,
                  child: ElevatedButton(
                    onPressed: () async {
                      await signInWithEmailAndPassword(context);
                    },
                    child: Text('Sign In'),
                  ),),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.69,
                  left: MediaQuery.of(context).size.height * 0.08,
                  child: Text(
                    "Don't have an account?",
                    style: GoogleFonts.openSans(
                      color: Color(0xFFED6E1B),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.687,
                  right: MediaQuery.of(context).size.height * 0.06,
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
                    },
                    child: Text(
                      "SignUp",
                      style: GoogleFonts.openSans(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.75,
                  child: GoogleLoginButton(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

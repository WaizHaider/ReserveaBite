import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();

    // Function to send a password reset email
    Future<void> sendPasswordResetEmail(String email) async {
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
        // Password reset email sent successfully
      } catch (e) {
        // Handle errors, e.g., email not found or other issues
        print('Error: $e');
      }
    }

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
                  top: MediaQuery.sizeOf(context).height * 0.03,
                  left: MediaQuery.sizeOf(context).height * 0.03,
                  child: Text(
                    "Forget Password",
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
                  top: MediaQuery.sizeOf(context).height * 0.34,
                  child: Text(
                    "Enter your email to receive reset password link",
                    style: GoogleFonts.abel(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Colors.black87),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.39,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    width: MediaQuery.of(context).size.width * 0.75,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                          Radius.circular(22.0)),
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
                            vertical: 15.0),
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
                  top: MediaQuery.sizeOf(context).height * 0.52,
                  child: ElevatedButton(
                    onPressed: () async {
                      await sendPasswordResetEmail(emailController.text);
                      // Show a confirmation message to the user
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Password reset email sent.'),
                        ),
                      );
                    },
                    child: Text('Send Reset Email'),
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

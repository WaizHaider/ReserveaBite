import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final DatabaseReference _database = FirebaseDatabase.instance.ref('feedback'); // Replace 'users' with your Firebase Realtime Database reference

  final TextEditingController userNameController = TextEditingController();
  final TextEditingController userFriendlyController = TextEditingController();
  final TextEditingController servicesController = TextEditingController();
  final TextEditingController complainsController = TextEditingController();

  Future<void> feedbackData() async {
    User? user = auth.currentUser;
    if (user != null) {
      String userId = user.uid;
      print("User ID: $userId");

      try {
        // Create a formatted timestamp for this feedback entry
        var timestamp = DateTime.now().toUtc().toIso8601String();
        timestamp = timestamp.replaceAll('.', ''); // Remove '.' from timestamp
        timestamp = timestamp.replaceAll(':', ''); // Remove ':' from timestamp
        timestamp = timestamp.replaceAll('Z', ''); // Remove 'Z' from timestamp

        await _database.child('feedback/$userId/$timestamp').set({
          'username': userNameController.text,
          'userfriendly': userFriendlyController.text,
          'services': servicesController.text,
          'complains': complainsController.text,
        });

        print('Feedback data uploaded successfully');
      } catch (e) {
        print('Error uploading feedback data: $e');
      }
    } else {
      print("User not logged in");
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
                    "Feedback",
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
                      controller: userFriendlyController,
                      style: GoogleFonts.openSans(
                        // Set Google Fonts for the input text color
                        color: Colors.white, // Input text color
                        fontSize: 16,
                      ),
                      decoration: InputDecoration(
                        labelText: "User Friendly",
                        labelStyle: GoogleFonts.openSans(
                          // Use Google Fonts here
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        hintText: "Is it easy to use?",
                        hintStyle: GoogleFonts.openSans(
                          // Use Google Fonts here
                          color: Colors.white70,
                          fontSize: 14,
                        ),

                        prefixIcon: Icon(
                          Icons.beach_access_rounded,
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
                          return "Please enter your remarks";
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
                      controller: servicesController, // Create a TextEditingController for the phone number
                      keyboardType: TextInputType.text, // Set the keyboard type to phone number
                      style: GoogleFonts.openSans(
                        // Set Google Fonts for the input text color
                        color: Colors.white, // Input text color
                        fontSize: 16,
                      ),
                      decoration: InputDecoration(
                        labelText: "Services", // Change the label text
                        labelStyle: GoogleFonts.openSans(
                          // Use Google Fonts here
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        hintText: "your views about services", // Change the hint text
                        hintStyle: GoogleFonts.openSans(
                          // Use Google Fonts here
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                        prefixIcon: Icon(
                          Icons.room_service_rounded, // Change the prefix icon to a phone icon
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
                          return "Please enter your remarks";
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.65,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    width: MediaQuery.of(context).size.width * 0.75,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                          Radius.circular(22.0)), // Adjust the radius as needed
                      color: Colors.blue, // Background color of the container
                    ),
                    child: TextFormField(
                      controller: complainsController, // Create a TextEditingController for the phone number
                      keyboardType: TextInputType.text, // Set the keyboard type to phone number
                      style: GoogleFonts.openSans(
                        // Set Google Fonts for the input text color
                        color: Colors.white, // Input text color
                        fontSize: 16,
                      ),
                      decoration: InputDecoration(
                        labelText: "Complains", // Change the label text
                        labelStyle: GoogleFonts.openSans(
                          // Use Google Fonts here
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        hintText: "Any complains", // Change the hint text
                        hintStyle: GoogleFonts.openSans(
                          // Use Google Fonts here
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                        prefixIcon: Icon(
                          Icons.flag_circle, // Change the prefix icon to a phone icon
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
                          return "Please enter your remarks";
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.78,
                  child: ElevatedButton(
                    onPressed: feedbackData,
                    child: Text('Submit'),
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

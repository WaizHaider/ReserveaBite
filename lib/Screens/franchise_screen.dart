import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FranchiseScreen extends StatelessWidget {
  final String franchiseName;
  final String franchiseImageURL;

  FranchiseScreen({
    required this.franchiseName,
    required this.franchiseImageURL,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(franchiseName),
        backgroundColor: Color(0xFFED6E1B),
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.network(
            franchiseImageURL,
            width: 400,
            height: 200,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 10,),
          Text(
            franchiseName,
            style: GoogleFonts.abel(fontSize: 24, fontWeight: FontWeight.bold)
          ),
          // Add more content for the FranchiseScreen here
        ],
      ),
    );
  }
}
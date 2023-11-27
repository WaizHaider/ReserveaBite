import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Screens/franchise_screen.dart';

class FranchiseCard extends StatelessWidget {
  final String franchiseName;
  final String franchiseImageURL;

  const FranchiseCard({
    required this.franchiseName,
    required this.franchiseImageURL,
  });

  @override
  Widget build(BuildContext context) {
    final int maxCharacters = 12;
    String truncatedFoodName = franchiseName.length <= maxCharacters
        ? franchiseName
        : '${franchiseName.substring(0, maxCharacters)}...';

    return SizedBox(
      height: 130,
      width: 300,
      child: Card(
        color: Colors.white,
        child: GestureDetector(
          onTap: () {
            // Handle the onTap event by navigating to a new screen
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => FranchiseScreen(
                  franchiseName: franchiseName,
                  franchiseImageURL: franchiseImageURL,
                ),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    // Display the franchise image using Image.network
                    Image.network(
                      franchiseImageURL,
                      width: 100,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(width: 10),
                    Text(
                      truncatedFoodName,
                      style: GoogleFonts.abel(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff1034A6),
                      ),
                      maxLines: 1,
                    ),
                  ],
                ),
                SizedBox(height: 10),
                // Add other widget elements here as needed
              ],
            ),
          ),
        ),
      ),
    );
  }
}
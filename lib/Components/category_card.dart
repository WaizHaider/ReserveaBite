import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryCard extends StatelessWidget {
  final String imageUrl;
  final String foodName;
  final String franchiseName;
  final String price;
  final String category;
  final int maxCharacters; // Maximum characters for foodName

  CategoryCard({
    required this.imageUrl,
    required this.foodName,
    required this.franchiseName,
    required this.price,
    required this.category,
    this.maxCharacters = 50, // Provide a default value
  });

  @override
  Widget build(BuildContext context) {
    // Truncate the foodName if it exceeds maxCharacters
    String truncatedFoodName = foodName.length <= maxCharacters
        ? foodName
        : '${foodName.substring(0, maxCharacters)}...';

    return Card(
      elevation: 3, // Add some elevation for a shadow
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        width: 300,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(imageUrl), // Load image from URL
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                truncatedFoodName, // Use the truncated name
                style: GoogleFonts.abel(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff1034A6),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "By: " + franchiseName,
                style: GoogleFonts.abel(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "PKR " + "$price",
                style: GoogleFonts.abel(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFED6E1B),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

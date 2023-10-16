import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FranchiseCard extends StatelessWidget {
  final String franchiseName;

  const FranchiseCard({
    required this.franchiseName,
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                truncatedFoodName,
                style: GoogleFonts.abel(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff1034A6),
                ),
                maxLines: 1,
              ),
              SizedBox(height: 10),
              // Add other widget elements here as needed
            ],
          ),
        ),
      ),
    );
  }
}

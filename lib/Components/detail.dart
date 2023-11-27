import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  final String itemName;
  final double itemPrice;
  final String itemImage;

  DetailsScreen({
    required this.itemName,
    required this.itemPrice,
    required this.itemImage,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(itemName),
        backgroundColor: Color(0xFFED6E1B),
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(itemImage, width: 350, height: 250, fit: BoxFit.fill),
            Text(
              itemName,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'PKR $itemPrice',
              style: TextStyle(
                fontSize: 18,
                color: Colors.blue,
              ),
            ),
            // Add more content for the detail screen here
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

import 'item.dart';

class DetailScreen extends StatelessWidget {
  final FoodItem foodItem;
  final String takeawayText;

  DetailScreen({required this.foodItem, required this.takeawayText});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(foodItem.foodName)),
      body: Column(
        children: [
          // Display detailed information from foodItem
          Image.network(foodItem.imageUrl),
          Text("Food Name: ${foodItem.foodName}"),
          Text("Franchise: ${foodItem.franchiseName}"),
          Text("Price: PKR ${foodItem.price}"),
          Text("Category: ${foodItem.category}"),

          // Display takeawayText
          Text("Takeaway: $takeawayText"),
        ],
      ),
    );
  }
}

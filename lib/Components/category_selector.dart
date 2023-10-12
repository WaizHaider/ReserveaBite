import 'package:flutter/material.dart';

class MyCategorySelector extends StatefulWidget {
  @override
  _MyCategorySelectorState createState() => _MyCategorySelectorState();
}

class _MyCategorySelectorState extends State<MyCategorySelector> {
  String selectedCategory = "";

  Widget _buildCategoryItem({
    IconData? icon,
    String? text,
  }) {
    final isSelected = selectedCategory == text;
    final iconColor = isSelected ? Colors.orange : Colors.black;
    final textColor = isSelected ? Colors.orange : Colors.black;

    return InkWell(
      onTap: () {
        setState(() {
          selectedCategory = text ?? "";
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Icon(
                icon,
                size: 30,
                color: iconColor,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              text ?? "",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Burger Category
        InkWell(
          onTap: () {
            setState(() {
              selectedCategory = "Burger";
            });
          },
          child: _buildCategoryItem(
            icon: Icons.fastfood,
            text: "Burger", // Pass non-nullable String
          ),
        ),
        // Pizza Category
        InkWell(
          onTap: () {
            setState(() {
              selectedCategory = "Pizza";
            });
          },
          child: _buildCategoryItem(
            icon: Icons.local_pizza_rounded,
            text: 'Pizza',
          ),
        ),
        // Desserts Category
        InkWell(
          onTap: () {
            setState(() {
              selectedCategory = "Desserts";
            });
          },
          child: _buildCategoryItem(
            icon: Icons.cake,
            text: 'Desserts',
          ),
        ),
        // Side Orders Category
        InkWell(
          onTap: () {
            setState(() {
              selectedCategory = "Side Orders";
            });
          },
          child: _buildCategoryItem(
            icon: Icons.restaurant_menu,
            text: 'Side Orders',
          ),
        ),
        // Ice Cream Category
        InkWell(
          onTap: () {
            setState(() {
              selectedCategory = "Ice Cream";
            });
          },
          child: _buildCategoryItem(
            icon: Icons.icecream,
            text: 'Ice Cream',
          ),
        ),
        // Others Category
        InkWell(
          onTap: () {
            setState(() {
              selectedCategory = "Others";
            });
          },
          child: _buildCategoryItem(
            icon: Icons.more_horiz,
            text: 'Others',
          ),
        ),
      ],
    );
  }
}
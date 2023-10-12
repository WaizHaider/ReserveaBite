import'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';



class CategoryCard extends StatelessWidget {
  final String imageUrl;
  final String foodName;
  final String franchiseName;
  final double price;
  final String Category;
  const CategoryCard({
    required this.imageUrl, required this.foodName, required this.franchiseName, required this.price, required this.Category,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // color: Colors.pink,
      height: 280,
      width: 300,
      child: Stack(
        children: <Widget>[
          SizedBox(
            height: 250,
            child: Card(
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(imageUrl), // Corrected here
                          fit: BoxFit.cover,
                        ),
                      ),
                      height: 210,
                      width: 120,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Column(
                      children: [
                        SizedBox(height: 20,),
                        Text(foodName,style: GoogleFonts.abel(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xff1034A6)),
                        ),
                        SizedBox(height: 5,),
                        Text("By: "+franchiseName,style: GoogleFonts.abel(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey)),
                        SizedBox(height: 5,),
                        Text("Tour: $Category ",style: GoogleFonts.abel(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey)),
                        SizedBox(height: 5,),
                        //Stars
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
              top: 210,
              right: 30,
              child:Container(
                height: 60,
                width: 90,
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xff1034A6)
                ),
                child: Center(child: Text("PKR "+ "$price", style: GoogleFonts.abel(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white))),
              ))

        ],
      ),
    );
  }
}
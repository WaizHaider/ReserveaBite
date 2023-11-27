import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'item.dart';

class DetailScreen extends StatefulWidget {
  final FoodItem foodItem;
  final String takeawayText;

  DetailScreen({required this.foodItem, required this.takeawayText});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int quantity = 1;
  int spriteQuantity = 0;
  int pepsiQuantity = 0;
  int friesQuantity = 0;
  bool addSideOrders = false;
  bool sprite = false;
  bool fries = false;
  bool pepsi = false;
  int coldDrink = 75;
  int friesPrice = 150;
  int total = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.foodItem.franchiseName),
        backgroundColor: Color(0xFFED6E1B),
        elevation: 0,
        actions: [
          // Add a cart icon to the AppBar
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              // Add your cart logic here
              // For example, you can navigate to the cart screen
              // Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen()));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Display detailed information from foodItem
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: NetworkImage(widget.foodItem.imageUrl),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 28.0),
                          child: Text(
                            widget.foodItem.foodName +
                                "\n\n" +
                                widget.foodItem.franchiseName,
                            style: GoogleFonts.abel(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: Colors.grey[100],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Price: PKR ${(quantity * widget.foodItem.price).toStringAsFixed(2)}",
                        style: GoogleFonts.abel(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            // Ensure quantity doesn't go below 1
                            if (quantity > 1) {
                              setState(() {
                                quantity = quantity - 1;
                              });
                            }
                          },
                          icon: Icon(
                            CupertinoIcons.minus_circle_fill,
                            color: Color(0xFFED6E1B),
                          ),
                        ),
                        Text(
                          "$quantity",
                          style: GoogleFonts.abel(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              // You can add any necessary validation or constraints here
                              quantity = quantity + 1;
                            });
                          },
                          icon: Icon(
                            CupertinoIcons.plus_circle_fill,
                            color: Color(0xFFED6E1B),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: Colors.grey[100],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Add side orders',
                            style: GoogleFonts.abel(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Checkbox(
                          value: addSideOrders,
                          onChanged: (bool? value) {
                            setState(() {
                              addSideOrders = value!;
                            });
                          },
                        ),
                      ],
                    ),
                    if (addSideOrders) _sideOrders(),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: MediaQuery.sizeOf(context).height*0.09,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color(0xFFED6E1B),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Total: ${(calculateTotal())}',
                        style: GoogleFonts.abel(
                          fontSize: 21,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        'Add To Cart',
                        style: GoogleFonts.abel(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0), // Adjust the value as needed
                        ),
                        primary: Colors.white,
                      ),
                    ),
                    SizedBox(width: 5),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        'Place Order',
                        style: GoogleFonts.abel(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0), // Adjust the value as needed
                        ),
                        primary: Colors.white,
                      ),
                    ),
                  ],
                )
              ),
            ),
          ],
        ),
      ),
    );
  }
  String calculateTotal() {
    double total = (quantity * widget.foodItem.price +
        spriteQuantity * coldDrink +
        pepsiQuantity * coldDrink +
        friesQuantity * friesPrice) as double;

    return total.toString();
  }
  Widget _sideOrders() {
    return InkWell(
      onTap: () {},
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            color: Colors.grey[100],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Adjust the spacing between the image and text
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Sprite',
                        style: GoogleFonts.abel(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 160,
                    ),
                    IconButton(
                      onPressed: () {
                        // Ensure quantity doesn't go below 1
                        if (spriteQuantity > 0) {
                          setState(() {
                            spriteQuantity = spriteQuantity - 1;
                          });
                        }
                      },
                      icon: Icon(
                        CupertinoIcons.minus_circle_fill,
                        color: Color(0xFFED6E1B),
                      ),
                    ),
                    Text(
                      "$spriteQuantity",
                      style: GoogleFonts.abel(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          // You can add any necessary validation or constraints here
                          spriteQuantity = spriteQuantity + 1;
                        });
                      },
                      icon: Icon(
                        CupertinoIcons.plus_circle_fill,
                        color: Color(0xFFED6E1B),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.0, bottom: 8.0),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      'Price: $coldDrink',
                      style: GoogleFonts.abel(fontSize: 15),
                    ),
                  ),
                )
              ],
            ),
          ),
          Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            color: Colors.grey[100],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Adjust the spacing between the image and text
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Pepsi',
                        style: GoogleFonts.abel(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 160,
                    ),
                    IconButton(
                      onPressed: () {
                        // Ensure quantity doesn't go below 1
                        if (pepsiQuantity > 0) {
                          setState(() {
                            pepsiQuantity = pepsiQuantity - 1;
                          });
                        }
                      },
                      icon: Icon(
                        CupertinoIcons.minus_circle_fill,
                        color: Color(0xFFED6E1B),
                      ),
                    ),
                    Text(
                      "$pepsiQuantity",
                      style: GoogleFonts.abel(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          // You can add any necessary validation or constraints here
                          pepsiQuantity = pepsiQuantity + 1;
                        });
                      },
                      icon: Icon(
                        CupertinoIcons.plus_circle_fill,
                        color: Color(0xFFED6E1B),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.0, bottom: 8.0),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      'Price: $coldDrink',
                      style: GoogleFonts.abel(fontSize: 15),
                    ),
                  ),
                )
              ],
            ),
          ),
          Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            color: Colors.grey[100],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Adjust the spacing between the image and text
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Fries',
                        style: GoogleFonts.abel(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 160,
                    ),
                    IconButton(
                      onPressed: () {
                        // Ensure quantity doesn't go below 1
                        if (friesQuantity > 0) {
                          setState(() {
                            friesQuantity = friesQuantity - 1;
                          });
                        }
                      },
                      icon: Icon(
                        CupertinoIcons.minus_circle_fill,
                        color: Color(0xFFED6E1B),
                      ),
                    ),
                    Text(
                      "$friesQuantity",
                      style: GoogleFonts.abel(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          // You can add any necessary validation or constraints here
                          friesQuantity = friesQuantity + 1;
                        });
                      },
                      icon: Icon(
                        CupertinoIcons.plus_circle_fill,
                        color: Color(0xFFED6E1B),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.0, bottom: 8.0),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      'Price: $friesPrice',
                      style: GoogleFonts.abel(fontSize: 15),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

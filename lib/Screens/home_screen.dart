import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reserveabite/Components/category_card.dart';
import 'package:reserveabite/class/burger.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isClicked = true;
  bool isClicked2 = false;
  String selectedCategory = '';

  void _toggleClick() {
    setState(() {
      isClicked = true;
      isClicked2 = false;
    });
  }

  void _toggleClick2() {
    setState(() {
      isClicked2 = true;
      isClicked = false;
    });
  }

  PageController _pageController = PageController();
  List<String> fastFoodImages = [
    'image1.png',
    'image2.jpg',
    'image3.jpg',
    'image4.jpg',
    // Add more image paths as needed
  ];
  int _currentPageIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  List<Map<String, dynamic>> items = [
    {
      'name': 'Fast Deal 1',
      'price': 150.0,
      'image': 'assets/image1.png',
      // Replace with the correct asset path or URL
    },
    {
      'name': 'Fast Deal 2',
      'price': 250.0,
      'image': 'assets/image2.jpg',
      // Replace with the correct asset path or URL
    },
    {
      'name': 'Fast Deal 3',
      'price': 500.0,
      'image': 'assets/image3.jpg',
      // Replace with the correct asset path or URL
    },
    {
      'name': 'Fast Deal 4',
      'price': 1000.0,
      'image': 'assets/image4.jpg',
      // Replace with the correct asset path or URL
    },
    // Add more items as needed
  ];

  void _startAutoScroll() {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (_currentPageIndex < fastFoodImages.length - 1) {
        _currentPageIndex++;
      } else {
        _currentPageIndex = 0;
      }
      _pageController.animateToPage(
        _currentPageIndex,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  Widget _buildPageIndicator() {
    List<Widget> indicators = [];

    for (int i = 0; i < fastFoodImages.length; i++) {
      indicators.add(
        Container(
          width: 8,
          height: 8,
          margin: EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentPageIndex == i ? Colors.orange : Colors.grey,
          ),
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: indicators,
    );
  }

  Future<dynamic> getBurgers() async {
    final allBurgers =
        await FirebaseDatabase.instance.ref('Takeaway Foods/Burger').get();
    // debugPrint(allBurgers.children.toString());
    //each children is a map of Maps of Burgers that have data
    //so we need to iterate over each children and get the data
    //then we need to add it to a list of burgers
    //then we need to return the list of burgers
    List branches = [];
    //getting branches
    for (var branch in allBurgers.children) {
      // debugPrint("\n\n" + branch.value.toString());
      branches.add(branch.value);
    }
    List burgers = [];
    //getting burgers from each branch
    for (var branch in branches) {
      for (var burger in branch.values) {
        // debugPrint("\n\n" + burger.toString());

        burgers.add(burger);
      }
    }
    debugPrint("Burgers length${burgers.length}");
    // debugPrint("Food name"+burgers[0].foodName);
    return burgers;
  }

  @override
  Widget build(BuildContext context) {
    getBurgers();
    Color containerColor = isClicked ? Color(0xFFED6E1B) : Colors.white;
    Color containerColor2 = isClicked2 ? Color(0xFFED6E1B) : Colors.white;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ReseraBite',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xFFED6E1B),
          ),
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(
                Icons.menu,
                color: Color(0xFFED6E1B),
              ), // Drawer icon
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      drawer: Drawer(
        width: MediaQuery.sizeOf(context).width * 0.55,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(
                "Waiz Haider",
                style:
                    GoogleFonts.abel(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              accountEmail: Text(
                "w1a2i3z4@gmail.com",
                style: GoogleFonts.abel(fontSize: 16),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.person,
                  color: Colors.black,
                ),
              ),
              decoration: BoxDecoration(
                color: Color(0xFFED6E1B),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.track_changes_sharp,
                color: Colors.blue,
              ),
              title: Text(
                'Track your Orders',
                style:
                    GoogleFonts.abel(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                // Handle Option 1
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.history_outlined,
                color: Colors.blue,
              ),
              title: Text(
                'Order History',
                style:
                    GoogleFonts.abel(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                // Handle Option 2
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.payment_outlined,
                color: Colors.blue,
              ),
              title: Text(
                'Payments',
                style:
                    GoogleFonts.abel(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                // Handle Option 2
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.star_rate_rounded,
                color: Colors.blue,
              ),
              title: Text(
                'Rate Us',
                style:
                    GoogleFonts.abel(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                // Handle Option 2
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.settings,
                color: Colors.blue,
              ),
              title: Text(
                'Settings',
                style:
                    GoogleFonts.abel(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                // Handle Option 2
                Navigator.pop(context);
              },
            ),
            // Add more drawer items as needed
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Dine In Takeaway Code
            Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                          color: Color(0xFFED6E1B),
                          borderRadius: BorderRadius.circular(30)),
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.search),
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40, top: 10),
                    child: GestureDetector(
                      onTap: () {
                        _toggleClick();
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        width: MediaQuery.of(context).size.width * 0.2,
                        height: MediaQuery.of(context).size.height * 0.05,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: containerColor,
                        ),
                        child: Center(
                          child: Text(
                            'Dine In',
                            style: GoogleFonts.abel(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: isClicked ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 10),
                    child: GestureDetector(
                      onTap: () {
                        _toggleClick2();
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        width: MediaQuery.of(context).size.width * 0.2,
                        height: MediaQuery.of(context).size.height * 0.05,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: containerColor2,
                        ),
                        child: Center(
                          child: Text(
                            'Takeaway',
                            style: GoogleFonts.abel(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: isClicked2 ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 200, // Adjust the height as needed
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: fastFoodImages.length,
                  itemBuilder: (context, index) {
                    return Image.asset(
                      'assets/${fastFoodImages[index]}',
                      fit: BoxFit.cover,
                    );
                  },
                  onPageChanged: (index) {
                    setState(() {
                      _currentPageIndex = index;
                    });
                  },
                ),
              ),
            ),
            _buildPageIndicator(),
            Visibility(
              visible: isClicked2,
              child: _menubar(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _menubar() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              height: MediaQuery.sizeOf(context).height,
              width: MediaQuery.sizeOf(context).width,
              decoration: BoxDecoration(
                color: Colors.grey[300],
              ),
            ),
            Positioned(
              top: MediaQuery.sizeOf(context).height * 0.008,
              child: Container(
                height: MediaQuery.sizeOf(context).height * 0.1,
                width: MediaQuery.sizeOf(context).width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      // Burger Category
                      _buildCategoryItem(
                        icon: Icons.fastfood,
                        text: "Burger",
                        isSelected: selectedCategory == "Burger",
                        onTap: () {
                          setState(() {
                            selectedCategory = "Burger";
                          });
                        },
                      ),
                      // Pizza Category
                      _buildCategoryItem(
                        icon: Icons.local_pizza_rounded,
                        text: 'Pizza',
                        isSelected: selectedCategory == "Pizza",
                        onTap: () {
                          setState(() {
                            selectedCategory = "Pizza";
                          });
                        },
                      ),
                      // Desserts Category
                      _buildCategoryItem(
                        icon: Icons.cake,
                        text: 'Desserts',
                        isSelected: selectedCategory == "Desserts",
                        onTap: () {
                          setState(() {
                            selectedCategory = "Desserts";
                          });
                        },
                      ),
                      // Side Orders Category
                      _buildCategoryItem(
                        icon: Icons.restaurant_menu,
                        text: 'Side Orders',
                        isSelected: selectedCategory == "Side Orders",
                        onTap: () {
                          setState(() {
                            selectedCategory = "Side Orders";
                          });
                        },
                      ),
                      // Ice Cream Category
                      _buildCategoryItem(
                        icon: Icons.icecream,
                        text: 'Ice Cream',
                        isSelected: selectedCategory == "Ice Cream",
                        onTap: () {
                          setState(() {
                            selectedCategory = "Ice Cream";
                          });
                        },
                      ),
                      // Others Category
                      _buildCategoryItem(
                        icon: Icons.more_horiz,
                        text: 'Others',
                        isSelected: selectedCategory == "Others",
                        onTap: () {
                          setState(() {
                            selectedCategory = "Others";
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.115,
              left: MediaQuery.of(context).size.width *
                  0.01, // Adjust left position as needed
              child: Container(
                height: MediaQuery.of(context).size.height * 0.23,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.125,
              left: MediaQuery.of(context).size.width * 0.03,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.04,
                width: MediaQuery.of(context).size.width * 0.27,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Color(0xFFED6E1B), // Border color
                    width: 3.0, // Border width
                  ),
                ),
                child: Center(
                  child: Text(
                    'Recommended',
                    style: GoogleFonts.abel(
                        fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.129,
              right: MediaQuery.of(context).size.width * 0.08,
              child: Text('See all',
                  style: GoogleFonts.abel(
                      fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.17,
              right: MediaQuery.of(context).size.width * 0.08,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.17,
                width: MediaQuery.of(context).size.width,
                color: Colors.grey[100],
                child: Padding(
                  padding: const EdgeInsets.only(left: 28.0),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: items.length,
                    itemBuilder: (BuildContext context, int index) {
                      String itemName = items[index]['name'];
                      double itemPrice = items[index]['price'];
                      String itemImage = items[index]['image'];

                      return Card(
                        margin: EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Container(
                              height: 70,
                              width: 90,
                              child: Image.asset(itemImage,
                                  fit: BoxFit
                                      .fill), // Use Image.asset to display the image
                            ),
                            Text(
                              itemName,
                              style: GoogleFonts.abel(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'PKR $itemPrice',
                              style: GoogleFonts.abel(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            /*Positioned(
              top: MediaQuery.of(context).size.height * 0.37,
              right: MediaQuery.of(context).size.width * 0.09,
              child: FutureBuilder(
                future: fetchCategoryData(selectedCategory), // Fetch data for the selected category
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    List<dynamic> items = snapshot.data ?? [];
                    return Container(
                      height: MediaQuery.of(context).size.height * 0.17,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.grey[100],
                      child: Padding(
                        padding: const EdgeInsets.only(left: 28.0),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: items.length,
                          itemBuilder: (BuildContext context, int index) {
                            // Display your data here
                            String itemName = items[index]['food name'];
                            double itemPrice = double.parse(items[index]['price']);
                            String itemImage = items[index]['image'];

                            return Card(
                              margin: EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Container(
                                    height: 70,
                                    width: 90,
                                    child: Image.network(
                                      itemImage, // Use Image.network for URL-based images
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  Text(
                                    itemName,
                                    style: GoogleFonts.abel(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'PKR $itemPrice',
                                    style: GoogleFonts.abel(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  } else {
                    return Text('No data available');
                  }
                },
              ),
            )*/
          ],
        ),
        SizedBox(
          height: 20,
        ),
        FutureBuilder(
          future: getBurgers(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // List<Burger> burgers = snapshot.data as List<Burger>;
              return SizedBox(
                height: 200,
                width: 200,
                child: Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(snapshot.data[index]['food name']),
                      );
                    },
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return Text("Error");
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ],
    );
  }

/*  Future<List<dynamic>> fetchCategoryData(String category) async {
    DatabaseReference foodsReference = FirebaseDatabase.instance.ref().child("Takeaway Foods").child(category);

    try {
      DataSnapshot snapshot = (await foodsReference.once()) as DataSnapshot;
      if (snapshot.value != null) {
        var data = snapshot.value;
        if (data is Map<dynamic, dynamic>) {
          return data.values.toList();
        }
      }
    } catch (error) {
      print('Error fetching data for $category: $error');
    }

    return [];
  }*/
  Widget _buildCategoryItem({
    IconData? icon,
    String? text,
    bool isSelected = false,
    VoidCallback? onTap,
  }) {
    final iconColor = isSelected ? Colors.orange : Colors.black;
    final textColor = isSelected ? Colors.orange : Colors.black;

    return InkWell(
      onTap: onTap,
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
}

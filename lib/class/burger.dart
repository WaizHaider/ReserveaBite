import 'package:firebase_database/firebase_database.dart';

class  Burger {
  final String category;
  final String foodName;
  final String foodImage;
  final String foodPrice;
  final String franchiseName;

  Burger({
    required this.category,
    required this.foodName,
    required this.foodImage,
    required this.foodPrice,
    required this.franchiseName,
  });

  //toMap
  Map<String, dynamic> toMap() {
    return {
      'category': category,
      'food name': foodName,
      'image': foodImage,
      'price': foodPrice,
      'franchise name': franchiseName,
    };
  }

  //fromMap
  factory Burger.fromMap(Map<String, dynamic> map) {
    return Burger(
      category: map['category'],
      foodName: map['food name'],
      foodImage: map['image'],
      foodPrice: map['price'],
      franchiseName: map['franchise name'],
    );
  }

  // //froDataSnapshot
  // factory Burger.fromDataSnapshot(DataSnapshot snapshot) {
  //   return Burger(
  //     category: snapshot.value!['category']?? '',
  //     foodName: snapshot.value['food name'],
  //     foodImage: snapshot.value['image'],
  //     foodPrice: snapshot.value['price'],
  //     franchiseName: snapshot.value['franchise name'],
  //   );
  // }
}
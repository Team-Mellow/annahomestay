import 'package:cloud_firestore/cloud_firestore.dart';

class Homestay {
  final String? id;
  final String houseName;
  final String category;
  final int capacity;
  final double price;
  final String imageUrl;

  const Homestay({
    this.id,
    required this.houseName,
    required this.category,
    required this.capacity,
    required this.price,
    required this.imageUrl,
  });

  toJson() {
    return {
      "HouseName": houseName,
      "Category": category,
      "Capacity": capacity,
      "Price": price,
      "ImageUrl": imageUrl,
    };
  }

  //Map homestay from firebase to homestayModel
  factory Homestay.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;

    return Homestay(
      id: document.id,
      houseName: data["HouseName"],
      category: data["Category"],
      capacity: data["Capacity"],
      price: data["Price"],
      imageUrl: data["ImageUrl"],
    );
  }

  // Create a Map for deletion
  Map<String, dynamic> toDeleteMap() {
    return {"HouseName": FieldValue.delete()};
  }
}

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class House {
//   final String? id;
//   final String name;
//   final String category;
//   final double price;
//   final int capacity;

//   House({
//     this.id,
//     required this.name,
//     required this.category,
//     required this.price,
//     required this.capacity,
//   });

//   toJson() {
//     return {
//       "HouseName": name,
//       "Category": category,
//       "Price": price,
//       "Capacity": capacity,
//     };
//   }

//   //map house fetched from firebase to housemodel
//   factory House.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
//     final data = document.data()!;
//     return House(
//         id: document.id,
//         name: data["HouseName"],
//         category: data["Category"],
//         price: data["Price"],
//         capacity: data["Capacity"]);
//   }
// }

// class HouseRepository extends GetxController {
//   static HouseRepository get instance => Get.find();

//   final _db = FirebaseFirestore.instance;

// //store house in FireStore
//   createHouse(House house) async {
//     await _db.collection("Houses").add(house.toJson()).whenComplete(() =>
//         Get.snackbar("Success", "A house has been created",
//             snackPosition: SnackPosition.BOTTOM,
//             backgroundColor: Colors.green.withOpacity(0.1),
//             colorText: Colors.green));
//   }

//   //fetch all house or house details

//   Future<House> allHouse() async {
//     // final snapshot = await _db.collection("Homestay").get();
//     // final houseData = snapshot.docs.map((e) => House.fromSnapshot(e)).single;
//     // return houseData;
//     List<House> houseList = [];

//     final documentSnapshot = await _db.collection('Homestay').get();
//     houseList = documentSnapshot.data()['house'];
//   }
// }

// class HomeRepo extends StatefulWidget {
//   const HomeRepo({super.key});

//   @override
//   State<HomeRepo> createState() => _HomeRepoState();
// }

// class _HomeRepoState extends State<HomeRepo> {
//   @override
//   Widget build(BuildContext context) {
//     List<House> house = [];

//     return Scaffold(
//         body: Container(
//             child: ListView.builder(
//                 padding: EdgeInsets.all(10),
//                 itemCount: house.length,
//                 itemBuilder: (context, index) {
//                   return CustomTile(mini: false, onTap: () {}, title: Text());
//                 })));
//   }
// }

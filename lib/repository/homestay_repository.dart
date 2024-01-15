import 'dart:async';

import 'package:annahomestay/models/homestay.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomestayRepository extends GetxController {
  static HomestayRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  //store homestay in FireStore
  createHomestay(Homestay homestay) async {
    try {
      await _db.collection("Homestay2").add(homestay.toJson());
      //       (value) => Get.snackbar(
      //         "Success",
      //         "Your Homestay has been added.",
      //         snackPosition: SnackPosition.BOTTOM,
      //         backgroundColor: Colors.green.withOpacity(0.1),
      //         colorText: Colors.green,
      //       ),
      //     );
    } catch (error) {
      Get.snackbar(
        "Error",
        "Something went wrong. Try again",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent.withOpacity(0.1),
        colorText: Colors.red,
      );
      print("ERROR - $error");
    }
  }

  Future<int> getTotalPropertyCount() async {
    try {
      // Assuming you are using Firebase Firestore
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('Homestay2').get();
      return snapshot.size;
    } catch (e) {
      print('Error fetching total property count: $e');
      throw 'Something went wrong';
    }
  }

  //fetch homestay details
  // Future<List<Homestay>> getAllHomestayDetails() async {
  //   final snapshot = await _db.collection("Homestay2").get();
  //   final homestayData =
  //       snapshot.docs.map((e) => Homestay.fromSnapshot(e)).toList();
  //   return homestayData;
  // }
  Stream<List<Homestay>> getAllHomestayDetails() {
    try {
      // Create a StreamController to broadcast the homestay data
      final StreamController<List<Homestay>> _controller =
          StreamController<List<Homestay>>();

      // Listen to the snapshots, and add transformed data to the stream
      _db.collection("homestay2").snapshots().listen((snapshot) {
        final homestayData =
            snapshot.docs.map((e) => Homestay.fromSnapshot(e)).toList();
        _controller.add(homestayData);
      }, onError: (error) {
        // In case of an error, add an empty list to the stream
        _controller.add([]);
        print("Error fetching homestay details: $error");
      });

      // Return the stream
      return _controller.stream;
    } catch (error) {
      // In case of an error, return a stream with an empty list
      return Stream.value([]);
    }
  }

  Future<void> updateHomestay(
      Homestay updatedHomestay, Homestay homestay) async {
    try {
      print('Before Update: ${homestay.toJson()}');

      // Check if homestay.id is not null before updating
      if (homestay.id != null) {
        final homestayRef = _db.collection('Homestay2').doc(homestay.id);

        // Convert updatedHomestay to a map and update the fields
        final Map<String, dynamic> updateData = updatedHomestay.toJson();
        await homestayRef.update(updateData);

        print('After Update: ${updateData}');
      } else {
        print('Homestay ID is null. Cannot update.');
      }
    } on FirebaseException catch (e) {
      throw e.message ?? 'Something went wrong.';
    } catch (e) {
      throw 'Something went wrong.';
    }
  }

  // Remove homestay in Firestore
  Future<void> removeHomestay(Homestay homestay) async {
    try {
      final homestayRef = _db.collection('Homestay2').doc(homestay.id);
      await homestayRef.delete();
    } catch (e) {
      throw 'Something went wrong';
    }
  }
}

import 'package:annahomestay/homestay.dart';
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

  //fetch homestay details
  Future<List<Homestay>> getAllHomestayDetails() async {
    final snapshot = await _db.collection("Homestay2").get();
    final homestayData =
        snapshot.docs.map((e) => Homestay.fromSnapshot(e)).toList();
    return homestayData;
  }

//update homestay details
  Future<void> updateHomestayDetails(Homestay updateHomestay) async {
    try {
      await _db
          .collection('Homestay2')
          .doc(updateHomestay.id)
          .update(updateHomestay.toJson());
    } on FirebaseException catch (e) {
      throw e.toString();
    } catch (e) {
      throw 'Something went wrong.';
    }
  }

  //update any field in homestay
  Future<void> updateSingleHomestay(Map<String, dynamic> json) async {
    try {
      await _db.collection('Homestay2').doc().update(json);
    } catch (e) {
      throw 'Something went wrong';
    }
  }

  // //remove homestay in FireStore
  // Future<void> removeHomestay(String houseId) async {
  //   try {
  //     await _db.collection('Homestay2').doc(houseId).delete();
  //   } catch (e) {
  //     throw 'Something went wrong';
  //   }
  // }

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

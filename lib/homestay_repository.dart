import 'homestay_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomestayRepository extends GetxController {
  static HomestayRepository get instance => Get.put(HomestayRepository());

  final _db = FirebaseFirestore.instance;

  //fetch homestay details
  Future<List<Homestay>> getAllHomestayDetails() async {
    final snapshot = await _db.collection("Homestay2").get();
    final homestayData =
        snapshot.docs.map((e) => Homestay.fromSnapshot(e)).toList();
    return homestayData;
  }

  Future<void> updateHomestay(Homestay updatedHomestay) async {
    try {
      await _db.collection('Homestay2').doc(updatedHomestay.id).update(
            updatedHomestay.toJson(),
          );
    } on FirebaseException catch (e) {
      throw e.message ?? 'Something went wrong.';
    } catch (e) {
      throw 'Something went wrong.';
    }
  }

  // Fetch homestay names
  Future<List<String>> fetchHomestayNames() async {
    try {
      final snapshot = await _db.collection("Homestay2").get();
      final homestayNames =
          snapshot.docs.map((e) => e.get('HouseName')).toList();
      return homestayNames.cast<String>();
    } catch (e) {
      throw 'Error fetching homestay names: $e';
    }
  }
}

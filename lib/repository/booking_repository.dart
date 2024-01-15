import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:annahomestay/models/booking.dart';

class BookingRepository extends GetxController {
  static BookingRepository get instance => Get.find();

  FirebaseFirestore _db = FirebaseFirestore.instance;

  // Change _db to _db
  createBooking(BookingModel booking) async {
    await _db.collection("bookings").add(booking.toJson()).then((value) {
      Get.snackbar(
        "Success",
        "Your booking has been registered",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.indigo[900],
        colorText: Colors.white,
      );
    }).catchError((error, stackTrace) {
      Get.snackbar("Error", "Something went wrong, try again",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red[400],
          colorText: Colors.white);
      print("ERROR - $error");
    });
  }

  Future<int> getTotalBookingCount() async {
    try {
      // Assuming you are using Firebase Firestore
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('bookings').get();
      return snapshot.size;
    } catch (e) {
      print('Error fetching total property count: $e');
      throw 'Something went wrong';
    }
  }

  //fetch booking details
  Future<List<BookingModel>> getAllBookingDetails() async {
    final snapshot = await _db.collection("bookings").get();
    final bookingData =
        snapshot.docs.map((e) => BookingModel.fromSnapshot(e)).toList();
    return bookingData;
  }

  // Remove booking in Firestore
  Future<void> removeBooking(BookingModel booking) async {
    try {
      final bookingRef = _db.collection('bookings').doc(booking.id);
      await bookingRef.delete();
    } catch (e) {
      throw 'Something went wrong';
    }
  }

  Future<void> updateApproval(
      BookingModel booking, String approvalValue) async {
    try {
      final bookingRef = _db.collection('bookings').doc(booking.id);

      await bookingRef.update({
        'approval': approvalValue,
        // Add any other fields you want to update here
      });
    } catch (e) {
      throw 'Something went wrong';
    }
  }
}

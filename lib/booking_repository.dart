import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'booking_model.dart';

class BookingRepository extends GetxController {
  static BookingRepository get instance => Get.find();

  FirebaseFirestore _db = FirebaseFirestore.instance;
  CollectionReference bookingsCollection =
      FirebaseFirestore.instance.collection('bookings');

  // Save booking data to Firestore
  Future<void> createBooking(BookingModel booking) async {
    try {
      DocumentReference documentReference =
          await bookingsCollection.add(booking.toJson());
      String bookingId =
          documentReference.id; // Get the ID from the DocumentReference

      // Update the booking with the ID
      booking.id = bookingId;

      // Display a success snackbar
      Get.snackbar(
        "Success",
        "Your booking has been registered",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.indigo[900],
        colorText: Colors.white,
      );
    } catch (error) {
      // Display an error snackbar
      Get.snackbar("Error", "Something went wrong, try again",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red[400],
          colorText: Colors.white);
      print("ERROR - $error");
    }
  }

// Delete a booking from Firestore
  Future<void> deleteBooking(String bookingId) async {
    try {
      await bookingsCollection.doc(bookingId).delete();
      Get.snackbar(
        "Success",
        "Your booking has been canceled",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.indigo[900],
        colorText: Colors.white,
      );
    } catch (error) {
      Get.snackbar("Error", "Something went wrong, try again",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red[400],
          colorText: Colors.white);
      print("ERROR - $error");
    }
  }

  // Retrieve bookings from Firestore
  Stream<List<BookingModel>> getBookings() {
    return bookingsCollection.snapshots().map(
          (snapshot) => snapshot.docs
              .map(
                (doc) =>
                    BookingModel.fromMap(doc.data() as Map<String, dynamic>),
              )
              .toList(),
        );
  }
}

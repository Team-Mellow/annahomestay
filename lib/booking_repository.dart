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

  Future<Map<String, Map<String, dynamic>>> checkAvailabilityForEachHouse(
      Timestamp checkIn, Timestamp checkOut) async {
    Map<String, Map<String, dynamic>> availability = {};

    // Get all homestays and initialize them as available
    var homestaysSnapshot =
        await FirebaseFirestore.instance.collection('Homestay2').get();
    for (var homestayDoc in homestaysSnapshot.docs) {
      var homestayData = homestayDoc.data() as Map<String, dynamic>;
      String? homestayName = homestayData['HouseName'];
      if (homestayName != null) {
        availability[homestayName] = {
          'Available': true,
          'Price': homestayData['Price'],
          'Capacity': homestayData['Capacity']
        };
      }
    }

    // Get all bookings and update availability if there is an overlap
    var bookingsSnapshot =
        await FirebaseFirestore.instance.collection('bookings').get();
    for (var bookingDoc in bookingsSnapshot.docs) {
      var bookingData = bookingDoc.data() as Map<String, dynamic>;
      String? homestayName = bookingData['homestay'];

      if (homestayName == null || !availability.containsKey(homestayName)) {
        continue; // Skip if the homestay name is null or not in the availability map
      }

      Timestamp bookingCheckIn = bookingData['checkInDate'];
      Timestamp bookingCheckOut = bookingData['checkOutDate'];

      // Check if the booking overlaps with the input date range
      bool isOverlapping =
          checkIn.toDate().isBefore(bookingCheckOut.toDate()) &&
              checkOut.toDate().isAfter(bookingCheckIn.toDate());

      // If there is an overlap, set the homestay as unavailable
      if (isOverlapping) {
        availability[homestayName]!['Available'] =
            false; // Use ! to assert that the key exists
      }
    }

    return availability;
  }

  // Save booking data to Firestore
  Future<void> createBooking(BookingModel booking) async {
    try {
      DocumentReference documentReference =
          await bookingsCollection.add(booking.toJson());
      String bookingId =
          documentReference.id; // Get the ID from the DocumentReference

      // Update the booking with the ID
      booking.id = bookingId;
      booking.approval = 'pending';

      //save the updated booking to Firestore
      await documentReference.update({
        'approval': "pending",
        'keycode': '',
      });

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
  // Inside your BookingRepository class
  Future<void> deleteBooking(String bookingId) async {
    try {
      print("Deleting booking with ID: $bookingId");
      await bookingsCollection.doc(bookingId).delete();
      Get.snackbar(
        "Success",
        "Your booking has been canceled",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.indigo[900],
        colorText: Colors.white,
      );
    } catch (error, stackTrace) {
      Get.snackbar("Error", "Something went wrong, try again",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red[400],
          colorText: Colors.white);
      print("ERROR - $error");
      print("STACK TRACE - $stackTrace");
    }
  }

  // Inside your BookingRepository class
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

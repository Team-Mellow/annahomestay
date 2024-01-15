import 'package:annahomestay/models/booking.dart';
import 'package:annahomestay/repository/booking_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingController extends GetxController {
  static BookingController get instance => Get.find();

  final name = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  final homestay = TextEditingController();
  final approval = TextEditingController();

  String selectedHomestay = '';
  DateTime? checkInDate;
  DateTime? checkOutDate;

  final bookingRepo = Get.put(BookingRepository());

  Future<int> getTotalBookingCount() async {
    return bookingRepo.getTotalBookingCount();
  }

  Future<void> createBooking(BookingModel booking) async {
    await bookingRepo.createBooking(booking);
  }

  getAllBookingDetails() {
    return bookingRepo.getAllBookingDetails();
  }

  Future<void> removeBooking(BookingModel booking) async {
    try {
      await bookingRepo.removeBooking(booking);
      update();
    } catch (e) {
      throw 'Something went wrong';
    }
  }

  Future<void> updateApproval(
      BookingModel booking, String approvalValue) async {
    try {
      await bookingRepo.updateApproval(booking, approvalValue);
      update();
    } catch (e) {
      throw 'Something went wrong';
    }
  }
}

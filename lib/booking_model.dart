import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:annahomestay/booking_model.dart';

// booking_model.dart

class BookingModel {
  late String name;
  late String email;
  late String phone;
  late String homestay;
  late DateTime? checkInDate;
  late DateTime? checkOutDate;

  BookingModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.homestay,
    required this.checkInDate,
    required this.checkOutDate,
  });

  // Create a factory method to convert a Map to a BookingModel
  factory BookingModel.fromMap(Map<String, dynamic> map) {
    return BookingModel(
      name: map['name'],
      email: map['email'],
      phone: map['phone'],
      homestay: map['homestay'],
      checkInDate: (map['checkInDate'] as Timestamp?)?.toDate(),
      checkOutDate: (map['checkOutDate'] as Timestamp?)?.toDate(),
    );
  }

  // Convert the BookingModel to a Map
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'homestay': homestay,
      'checkInDate': checkInDate,
      'checkOutDate': checkOutDate,
    };
  }
}

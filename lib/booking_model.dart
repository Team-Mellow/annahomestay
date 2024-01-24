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
  late String approval;
  late String keycode;

  String? id; // Add this line to include the id property

  BookingModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.homestay,
    required this.checkInDate,
    required this.checkOutDate,
    this.approval = 'pending',
    this.id,
    this.keycode = '',
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
      id: map['id'], // Add this line to include the id property
      approval: map['approval'] ??
          'pending', //Include the aproval field with a default value
      keycode: map['keycode'] ?? '', // Include the "keycode" field
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
      'id': id, // Add this line to include the id property
      'approval': approval, //Include the approval field
      'keycode': keycode //Include te "Keycode" field
    };
  }
}
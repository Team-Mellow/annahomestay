import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

class BookingModel {
  final String name;
  final String email;
  final String phone;
  final String homestay;
  final String checkInDate;
  final String checkOutDate;

  const BookingModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.homestay,
    required this.checkInDate,
    required this.checkOutDate,
  })
}

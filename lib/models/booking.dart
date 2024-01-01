import 'package:cloud_firestore/cloud_firestore.dart';

class BookingModel {
  final String? id;
  final String name;
  final String email;
  final String phone;
  final String homestay;
  final Timestamp checkInDate;
  final Timestamp checkOutDate;
  final String approval;

  const BookingModel({
    this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.homestay,
    required this.checkInDate,
    required this.checkOutDate,
    required this.approval,
  });

  toJson() {
    return {
      "name": name,
      "email": email,
      "phone": phone,
      "homestay": homestay,
      "checkInDate": checkInDate,
      "checkOutDate": checkOutDate,
      "approval": approval,
    };
  }

  //Map homestay from firebase to homestayModel
  factory BookingModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;

    return BookingModel(
        id: document.id,
        name: data["name"],
        email: data["email"],
        phone: data["phone"],
        homestay: data["homestay"],
        checkInDate: data["checkInDate"],
        checkOutDate: data["checkOutDate"],
        approval: data['approval']);
  }

  // Create a Map for deletion
  Map<String, dynamic> toDeleteMap() {
    return {"name": FieldValue.delete()};
  }
}

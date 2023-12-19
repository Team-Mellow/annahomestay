import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ManageReservation extends StatefulWidget {
  const ManageReservation({super.key});

  @override
  State<ManageReservation> createState() => _ManageReservationState();
}

class _ManageReservationState extends State<ManageReservation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Reservation'),
      ),
      body: Text('Manage Reservation Page'),
    );
  }
}

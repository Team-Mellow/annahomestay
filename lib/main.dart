import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'listscreen.dart';
import 'bookingscreen.dart';
import 'confirmationscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Homestay App',
      initialRoute: '/list',
      routes: {
        '/list': (context) => ListScreen(),
        '/booking': (context) => BookingScreen(),
        '/confirmation': (context) => ConfirmationScreen(),
      },
    );
  }
}

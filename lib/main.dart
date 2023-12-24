import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';
import 'listscreen.dart';
import 'bookingscreen.dart';
import 'confirmationscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyCJd8beOBOV1U5Dnx-S3XwooYVOxY9KSe4",
          appId: "1:425277120843:web:6d9cbdcc261924acd608ce",
          messagingSenderId: "425277120843",
          projectId: "annahomestay-ea338"));
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

import 'package:annahomestay/models/availabilityscreen.dart';
import 'package:annahomestay/models/homestayfilter.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';
import 'listscreen.dart';
import 'bookingscreenold.dart';
import 'confirmationscreen.dart';
import 'repository/booking_repository.dart';
import 'models/bookingscreen.dart';
import 'models/descriptionscreen.dart';
import 'package:get/get.dart';
//import 'package:stripe_payment/stripe_payment.dart';
//import 'package:razorpay_flutter/razorpay_flutter.dart';


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
    //  home: HomestayFilterPage(),
      debugShowCheckedModeBanner: false,
     initialRoute: '/list',
      routes: {
        '/list': (context) => ListScreen(),
        '/filter':(context) => HomestayFilterPage(),
        '/booking': (context) => BookingScreen(),
        '/availability': (context) => AvailabilityScreen(),
        '/confirmation': (context) => ConfirmationScreen(),
        '/description': (context) => DescriptionScreen(),
      }, 
    );
  }
}

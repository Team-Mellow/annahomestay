// booking_screen.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';


class BookingScreen extends StatefulWidget {
  @override
  _BookingScreenState createState() => _BookingScreenState();
}

String formatDate(DateTime date) {
  return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
}

class _BookingScreenState extends State<BookingScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileController = TextEditingController();

  String selectedHomestay = '';
  DateTime? checkInDate;
  DateTime? checkOutDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Booking Information',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.indigo[900],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row( 
                children: [ 
                  Icon(Icons.person, color: Theme.of(context).primaryColor), 
                  SizedBox(width: 8.0), 
                  Expanded( 
                    child: TextFormField( 
                      controller: nameController, 
                      decoration: InputDecoration( 
                        labelText: 'Name', 
                      ), 
                    ), 
                  ), 
                ], 
              ), 
              SizedBox(height: 16.0), 
 
              // Email input with icon 
              Row( 
                children: [ 
                  Icon(Icons.email, color: Theme.of(context).primaryColor), 
                  SizedBox(width: 8.0), 
                  Expanded( 
                    child: TextFormField( 
                      controller: emailController, 
                      decoration: InputDecoration( 
                        labelText: 'Email', 
                      ), 
                    ), 
                  ), 
                ], 
              ), 
              SizedBox(height: 16.0), 
 
              // Phone Number input with icon 
              Row( 
                children: [ 
                  Icon(Icons.phone, color: Theme.of(context).primaryColor), 
                  SizedBox(width: 8.0), 
                  Expanded( 
                    child: TextFormField( 
                      controller: mobileController, 
                      decoration: InputDecoration( 
                        labelText: 'Phone Number', 
                      ), 
                    ), 
                  ), 
                ], 
              ), 
              SizedBox(height: 16.0), 
 
              // Homestay selection 
              Text( 
                'Select Homestay:', 
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold), 
              ), 
              Column( 
                children: [ 
                  for (var homestay in [ 
                    'Angsana House', 
                    'Apsara Villa', 
                    'Chenang Stay', 
                    'Indah Home', 
                    'Dini Pavi' 
                  ]) 
                    Container( 
                      margin: EdgeInsets.symmetric(vertical: 8.0), 
                      padding: EdgeInsets.all(12.0), 
                      decoration: BoxDecoration( 
                        color: 
                            Colors.indigo[100], // Light blue background color 
                        borderRadius: BorderRadius.circular(10.0), 
                      ), 
                      child: RadioListTile<String>( 
                        title: Text( 
                          homestay, 
                          style: TextStyle( 
                            fontSize: 16.0, 
                            fontWeight: FontWeight.bold, 
                          ),

                          ), 
                        value: homestay, 
                        groupValue: selectedHomestay, 
                        onChanged: (value) { 
                          setState(() { 
                            selectedHomestay = value!; 
                          }); 
                        }, 
                      ), 
                    ), 
                ], 
              ), 
              SizedBox(height: 16.0), 
 
              // Date selection 
              Text( 
                'Select Dates:', 
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold), 
              ), 
              Row( 
                mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                children: [ ElevatedButton( 
                    onPressed: () async { 
                      final DateTime? pickedDate = await showDatePicker( 
                        context: context, 
                        initialDate: DateTime.now(), 
                        firstDate: DateTime.now(), 
                        lastDate: DateTime.now().add(Duration(days: 365)), 
                      ); 
                      if (pickedDate != null && pickedDate != checkInDate) { 
                        setState(() { 
                          checkInDate = pickedDate; 
                        }); 
                      } 
                    }, 
                    style: ElevatedButton.styleFrom( 
                      primary: Colors.indigo[900], // Dark blue background color 
                    ), 
                    child: Text('Check-in Date'), 
                  ), 
                  ElevatedButton( 
                    onPressed: () async { 
                      final DateTime? pickedDate = await showDatePicker( 
                        context: context, 
                        initialDate: DateTime.now(), 
                        firstDate: DateTime.now(), 
                        lastDate: DateTime.now().add(Duration(days: 365)), 
                      ); 
                      if (pickedDate != null && pickedDate != checkOutDate) { 
                        setState(() { 
                          checkOutDate = pickedDate; 
                        }); 
                      } 
                    }, 
                    style: ElevatedButton.styleFrom( 
                      primary: Colors.indigo[900], // Dark blue background color 
                    ), 
                    child: Text('Check-out Date'), 
                  ), 
                ], 
              ), 
              SizedBox(height: 16.0), 
 
              // Selected dates display 
              if (checkInDate != null && checkOutDate != null) 
                Text( 
                  'Selected Dates: Check-in - ${formatDate(checkInDate!)} | Check-out - ${formatDate(checkOutDate!)}', 
                  style: TextStyle(fontSize: 16.0), 
                ), 
 
              SizedBox(height: 16.0), 
   // ... Other code ...

              ElevatedButton(
                onPressed: () async {
                  // Initialize Firebase if not initialized
                  if (Firebase.apps.isEmpty) {
                    await Firebase.initializeApp();
                  }

                  // Insert booking data to Firestore
                  await insertBookingData();

                  // Navigate to the confirmation page with user input
                  Navigator.pushNamed(
                    context,
                    '/confirmation',
                    arguments: {
                      'name': nameController.text,
                      'email': emailController.text,
                      'phone': mobileController.text,
                      'homestay': selectedHomestay,
                      'checkInDate': checkInDate,
                      'checkOutDate': checkOutDate,
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.indigo[900], // Dark blue background color
                ),
                child: Text('Next'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> insertBookingData() async {
    try {
      final CollectionReference bookingsCollection =
          FirebaseFirestore.instance.collection('bookings');

      await bookingsCollection.add({
        'name': nameController.text,
        'email': emailController.text,
        'phone': mobileController.text,
        'homestay': selectedHomestay,
        'checkInDate': checkInDate,
        'checkOutDate': checkOutDate,
      });

      print('Booking data inserted successfully!');
    } catch (e) {
      print('Error inserting booking data: $e');
    }
  }
}

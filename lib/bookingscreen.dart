import 'package:flutter/material.dart';
import 'listscreen.dart';
import 'bookingscreen.dart';

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
        title: Text('Booking Information'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: mobileController,
                decoration: InputDecoration(labelText: 'Phone Number'),
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
                    RadioListTile<String>(
                      title: Text(homestay),
                      value: homestay,
                      groupValue: selectedHomestay,
                      onChanged: (value) {
                        setState(() {
                          selectedHomestay = value!;
                        });
                      },
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
                children: [
                  ElevatedButton(
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

              // "Next" button
              ElevatedButton(
                onPressed: () {
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
                child: Text('Next'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

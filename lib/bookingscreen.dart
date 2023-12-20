import 'package:flutter/material.dart';
import 'listscreen.dart';
import 'bookingscreen.dart';

class BookingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Information'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: nameController, // Add this line
              decoration: InputDecoration(labelText: 'Name'),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: emailController, // Add this line
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: mobileController, // Add this line
              decoration: InputDecoration(labelText: 'Phone Number'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/booking');
              },
              child: Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}

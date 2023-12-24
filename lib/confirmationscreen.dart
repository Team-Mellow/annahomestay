import 'package:flutter/material.dart';

class ConfirmationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Confirmation'),
        backgroundColor: Colors.indigo[900],
        iconTheme: IconThemeData(
            color: Colors.white), // Set the app bar color to dark blue
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Name: John Doe'),
            ),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text('Phone Number: +1 123-456-7890'),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Homestay Chosen: Angsana House'),
            ),
            ListTile(
              leading: Icon(Icons.calendar_today),
              title: Text('Date Check-in: 2023-05-01'),
            ),
            ListTile(
              leading: Icon(Icons.calendar_today),
              title: Text('Date Check-out: 2023-05-07'),
            ),
            ListTile(
              leading: Icon(Icons.attach_money),
              title: Text('Price: \$500.00'),
            ),
            Spacer(), // Add Spacer to push buttons to the bottom
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ElevatedButton(
            onPressed: () {
              print("Booking Canceled!");
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child: Container(
              width: 150.0, // Set a specific width for the button
              child: Center(
                child: Text(
                  'CANCEL',
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          ElevatedButton(
            onPressed: () {
              print("Booking Confirmed!");
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child: Container(
              width: 150.0, // Set a specific width for the button
              child: Center(
                child: Text(
                  'CONFIRM',
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class ConfirmationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Confirmation'),
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
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            width: 16.0,
          ),
          ElevatedButton(
            onPressed: () {
              print("Booking Canceled!");
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            child: Container(
              width: 70,
              child: Center(
                child: Text('CANCEL'),
              ),
            ),
          ),
          SizedBox(
            width: 16.0,
          ),
          ElevatedButton(
            onPressed: () {
              print("Booking Confirmed!");
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            child: Container(
              width: 70,
              child: Center(
                child: Text('CONFIRM'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

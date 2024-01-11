import 'package:flutter/material.dart';
import 'booking_repository.dart';
import 'booking_model.dart';

class BookingStatusPage extends StatelessWidget {
  final String fullName;
  final String homestayName;
  final String status;

  BookingStatusPage({
    required this.fullName,
    required this.homestayName,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    // Sample booking details. You should replace this with actual data.
    BookingModel booking = BookingModel(
      name: 'John Doe',
      email: 'john.doe@example.com',
      phone: '123-456-7890',
      homestay: 'Beautiful Homestay',
      checkInDate: DateTime.now(),
      checkOutDate: DateTime.now().add(Duration(days: 7)),
      approval: 'Pending',
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Status', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.indigo[900],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Full Name: $fullName',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Text(
              'Homestay Name: $homestayName',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Text(
              'Status: $status',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _showBookingDetailsDialog(context, booking);
              },
              child: Text('View Booking Details'),
            ),
          ],
        ),
      ),
    );
  }

  // Function to show a dialog with booking details in a dropdown
  Future<void> _showBookingDetailsDialog(
      BuildContext context, BookingModel booking) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Booking Details'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Full Name: ${booking.name}'),
              SizedBox(height: 8.0),
              Text('Homestay Name: ${booking.homestay}'),
              SizedBox(height: 8.0),
              Text('Status: ${booking.approval}'),
              // Add other fields here, such as phone number, email, date, etc.
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}

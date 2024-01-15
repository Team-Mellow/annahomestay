import 'package:flutter/material.dart';
import 'booking_model.dart';
import 'booking_repository.dart';

class ConfirmationScreen extends StatelessWidget {
  final BookingRepository _bookingRepository = BookingRepository.instance;

  String formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    // Retrieve data passed from BookingScreen
    Map<String, dynamic> bookingData =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    String? bookingId = bookingData['id'] ?? null; // Use null if 'id' is null

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Booking Confirmation',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.indigo[900],
        iconTheme: IconThemeData(
            color: Colors.white), // Set the app bar color to dark blue
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildInfoTile('Name', bookingData['name'], Icons.person),
            buildInfoTile('Phone Number', bookingData['phone'], Icons.phone),
            buildInfoTile(
                'Homestay Chosen', bookingData['homestay'], Icons.home),
            buildInfoTile('Date Check-in',
                formatDate(bookingData['checkInDate']), Icons.calendar_today),
            buildInfoTile('Date Check-out',
                formatDate(bookingData['checkOutDate']), Icons.calendar_today),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    bool confirm = await showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text("Confirm Cancellation"),
                        content: Text(
                            "Are you sure you want to cancel this booking?"),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: Text("No"),
                          ),
                          TextButton(
                            onPressed: () async {
                              Navigator.of(context).pop(true);

                              // If the user confirms, delete the booking
                              if (bookingId != null) {
                                await _bookingRepository
                                    .deleteBooking(bookingId);

                                // Close the confirmation screen
                                Navigator.of(context).pop();
                              } else {
                                // Handle the case where the id is null
                                print("Booking ID is null.");
                              }
                            },
                            child: Text("Yes"),
                          ),
                        ],
                      ),
                    );

                    // If the user confirms, delete the booking
                    if (confirm == true) {
                      if (bookingData['id'] != null) {
                        await _bookingRepository
                            .deleteBooking(bookingData['id']);

                        // Close the confirmation screen
                        Navigator.of(context).pop();
                      } else {
                        // Handle the case where the id is null
                        print("Booking ID is null.");
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Container(
                    width: 150.0,
                    child: Center(
                      child: Text(
                        'CANCEL',
                        style: TextStyle(fontSize: 16.0, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    // Show a confirmation message
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text("Booking Confirmed"),
                        content:
                            Text("Your booking is successfully registered!"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // Close the dialog
                              Navigator.pushReplacementNamed(
                                  context, '/list'); // Go to the list screen
                            },
                            child: Text("Go back to homepage"),
                          ),
                        ],
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.indigo[900],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Container(
                    width: 150.0,
                    child: Center(
                      child: Text(
                        'CONFIRM',
                        style: TextStyle(
                            fontSize: 16.0, color: Colors.orange[200]),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInfoTile(String title, String value, IconData icon) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.indigo[100], // Light blue background color
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.0, // Adjust the font size here
          ),
        ),
        subtitle: Text(
          value,
          style: TextStyle(fontSize: 16.0), // Adjust the font size here
        ),
        leading: Icon(icon),
      ),
    );
  }
}

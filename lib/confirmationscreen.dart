// confirmation_screen.dart
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
        child: StreamBuilder<List<BookingModel>>(
          stream: _bookingRepository.getBookings(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<BookingModel> bookings = snapshot.data!;
              if (bookings.isNotEmpty) {
                BookingModel latestBooking = bookings.last;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildInfoTile('Name', latestBooking.name, Icons.person),
                    buildInfoTile(
                        'Phone Number', latestBooking.phone, Icons.phone),
                    buildInfoTile(
                        'Homestay Chosen', latestBooking.homestay, Icons.home),
                    buildInfoTile(
                        'Date Check-in',
                        formatDate(latestBooking.checkInDate!),
                        Icons.calendar_today),
                    buildInfoTile(
                        'Date Check-out',
                        formatDate(latestBooking.checkOutDate!),
                        Icons.calendar_today),
                    SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            // Show a confirmation dialog
                            bool confirm = await showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text("Confirm Cancellation"),
                                content: Text(
                                    "Are you sure you want to cancel this booking?"),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(false),
                                    child: Text("No"),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(true),
                                    child: Text("Yes"),
                                  ),
                                ],
                              ),
                            );

                            // If the user confirms, delete the booking
                            if (confirm == true) {
                              if (latestBooking.id != null) {
                                await _bookingRepository
                                    .deleteBooking(latestBooking.id!);

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
                                style: TextStyle(
                                    fontSize: 16.0, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            // Your existing code for processing the booking

                            // Show a confirmation message
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text("Booking Confirmed"),
                                content: Text(
                                    "Your booking is successfully registered!"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pop(); // Close the dialog
                                      Navigator.pushReplacementNamed(context,
                                          '/list'); // Go to the list screen
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
                );
              }
            }
            return Center(child: CircularProgressIndicator());
          },
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

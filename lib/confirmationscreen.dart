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
                    buildInfoTile('Date Check-in', formatDate(DateTime.now()),
                        Icons.calendar_today),
                    buildInfoTile(
                        'Date Check-out',
                        formatDate(DateTime.now().add(Duration(days: 6))),
                        Icons.calendar_today),
                    SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                            width: 150.0,
                            child: Center(
                              child: Text(
                                'CANCEL',
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ),
                          ),
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
                            width: 150.0,
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
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(value),
      leading: Icon(icon),
    );
  }
}

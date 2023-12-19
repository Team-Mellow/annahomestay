import 'package:annahomestay/admin/generate_report.dart';
import 'package:annahomestay/admin/manage_property.dart';
import 'package:annahomestay/admin/manage_reservation.dart';
import 'package:annahomestay/admin/message_guest.dart';
import 'package:flutter/material.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome, Admin!',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      MaterialPageRoute route = MaterialPageRoute(
                          builder: (context) => ManageProperty());
                      Navigator.push(context, route);
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(100, 100), // Set the desired size
                    ),
                    child: Text('Manage Property Listings'),
                  ),
                ),

                SizedBox(height: 8.0), // Additional spacing between buttons
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      MaterialPageRoute route = MaterialPageRoute(
                          builder: (context) => ManageReservation());
                      Navigator.push(context, route);
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(100, 100), // Set the desired size
                    ),
                    child: Text('Manage Reservations'),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.0), // Additional spacing between buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      MaterialPageRoute route = MaterialPageRoute(
                          builder: (context) => MessageGuest());
                      Navigator.push(context, route);
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(100, 100), // Set the desired size
                    ),
                    child: Text('Message with Guests'),
                  ),
                ),

                SizedBox(height: 8.0), // Additional spacing between buttons
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      MaterialPageRoute route = MaterialPageRoute(
                          builder: (context) => GenerateReport());
                      Navigator.push(context, route);
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(100, 100), // Set the desired size
                    ),
                    child: Text('Generate Reports'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

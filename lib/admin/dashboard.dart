import 'package:annahomestay/admin/manage_booking.dart';
import 'package:annahomestay/admin/manage_property.dart';
import 'package:annahomestay/admin/manage_property2.dart';
import 'package:annahomestay/controller/manageBooking_controller.dart';
import 'package:annahomestay/controller/manageProperty_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  final homestayController = Get.put(HomestayController());
  final bookingController = Get.put(BookingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Admin Dashboard',
        ),
        backgroundColor: Colors.deepPurple[200],
        elevation: 0,
      ),
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 20.0),
              const Text(
                'Welcome, Admin!',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      MaterialPageRoute route = MaterialPageRoute(
                          builder: (context) => const ManageProperty2());
                      Navigator.push(context, route);
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(200, 90),
                      primary: Colors.deepPurple[100],
                      elevation: 0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          '../lib/photos/addHouseIcon.png',
                          height: 40,
                          width: 40,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(width: 8.0),
                        const Expanded(
                          child: Text(
                            'Manage Property Listings',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      MaterialPageRoute route = MaterialPageRoute(
                          builder: (context) => const ManageBooking());
                      Navigator.push(context, route);
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(200, 90),
                      primary: Colors.deepPurple[100],
                      elevation: 0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          '../lib/photos/key.png',
                          height: 40,
                          width: 40,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(width: 8.0),
                        const Expanded(
                          child: Text(
                            'Manage Customer Booking',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FutureBuilder<int>(
                    future: homestayController.getTotalPropertyCount(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return AnalyticsLayout1(
                          controller: homestayController, // Pass the controller
                          title: 'Total Property Listings',
                          value: snapshot.data?.toString() ?? '0',
                        );
                      }
                    },
                  ),
                  //Add other analytics layouts if needed
                  FutureBuilder<int>(
                    future: bookingController.getTotalBookingCount(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return AnalyticsLayout2(
                          controller: bookingController, // Pass the controller
                          title: 'Total Bookings',
                          value: snapshot.data?.toString() ?? '0',
                        );
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AnalyticsLayout1 extends StatelessWidget {
  final HomestayController controller; // Pass the controller as a parameter
  final String title;
  final String value;

  AnalyticsLayout1({
    Key? key,
    required this.controller,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.grey),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8.0),
          FutureBuilder<int>(
            future: controller.getTotalPropertyCount(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return Text(
                  snapshot.data?.toString() ?? '0',
                  style: const TextStyle(
                    fontSize: 16.0,
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class AnalyticsLayout2 extends StatelessWidget {
  final BookingController controller; // Pass the controller as a parameter
  final String title;
  final String value;

  AnalyticsLayout2({
    Key? key,
    required this.controller,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.grey),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8.0),
          FutureBuilder<int>(
            future: controller.getTotalBookingCount(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return Text(
                  snapshot.data?.toString() ?? '0',
                  style: const TextStyle(
                    fontSize: 16.0,
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

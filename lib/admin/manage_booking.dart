import 'package:flutter/material.dart';
import 'package:annahomestay/custBooking.dart';

class ManageBooking extends StatefulWidget {
  const ManageBooking({super.key});

  @override
  State<ManageBooking> createState() => _ManageBookingState();
}

class _ManageBookingState extends State<ManageBooking> {
  // Dummy data for booking list
  List<CustBooking> bookingList = [
    CustBooking(
        custName: 'Farhanah Aina',
        houseName: 'Angsana',
        totalStay: 2,
        totalprice: 400),
    CustBooking(
        custName: 'Dini Fatini',
        houseName: 'Indah',
        totalStay: 2,
        totalprice: 300)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Booking'),
      ),
      body: ListView.builder(
        itemCount: bookingList.length,
        itemBuilder: (context, index) {
          return BookingCard(booking: bookingList[index]);
        },
      ),
    );
  }
}

class BookingCard extends StatelessWidget {
  final CustBooking booking;
  const BookingCard({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      booking.custName,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text('House Name: ' + booking.houseName),
                    SizedBox(height: 8.0),
                    Text('Price: RM' + booking.totalprice.toString()),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 16.0,
            right: 16.0,
            child: FloatingActionButton.extended(
              onPressed: () {},
              icon: const Icon(Icons.check),
              label: const Text('Approve'),
            ),
          ),
        ],
      ),
    );
  }
}

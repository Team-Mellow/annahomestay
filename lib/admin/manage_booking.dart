import 'package:annahomestay/controller/manageBooking_controller.dart';
import 'package:annahomestay/models/booking.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:annahomestay/custBooking.dart';
import 'package:timestamp_to_string/timestamp_to_string.dart';
import 'package:get/get.dart';

class ManageBooking extends StatefulWidget {
  const ManageBooking({super.key});

  @override
  State<ManageBooking> createState() => _ManageBookingState();
}

class _ManageBookingState extends State<ManageBooking> {
  // Custom method to format timestamp as ddmmyy
  String formatTimestamp(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    String day = dateTime.day.toString().padLeft(2, '0');
    String month = dateTime.month.toString().padLeft(2, '0');
    String year = dateTime.year.toString().substring(0);
    return "$day-$month-$year";
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BookingController());
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Customer Booking'),
      ),
      // body: ListView.builder(
      //   itemCount: bookingList.length,
      //   itemBuilder: (context, index) {
      //     return BookingCard(booking: bookingList[index]);
      //   },
      // ),
      body: SingleChildScrollView(
        child: Container(
          child: FutureBuilder<List<BookingModel>>(
              future: controller.getAllBookingDetails(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (c, index) {
                        return SizedBox(
                            child: Card(
                          margin: EdgeInsets.all(8.0),
                          child: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          snapshot.data![index].homestay,
                                          style: TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 8.0),
                                        Text('Name: ' +
                                            snapshot.data![index].name),
                                        SizedBox(height: 8.0),
                                        Text('Email: ' +
                                            snapshot.data![index].email),
                                        SizedBox(height: 8.0),
                                        Text('Phone: ' +
                                            snapshot.data![index].phone),
                                        SizedBox(height: 8.0),
                                        //Text('Price: RM' + booking.totalprice.toString()),
                                        Text('Check In Date: ' +
                                            formatTimestamp(snapshot
                                                .data![index].checkInDate)),
                                        SizedBox(height: 8.0),
                                        Text('Check Out Date: ' +
                                            formatTimestamp(snapshot
                                                .data![index].checkOutDate)),
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
                        ));
                      });
                } else if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              }),
        ),
      ),
    );
  }
}

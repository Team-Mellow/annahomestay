import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BookingScreen extends StatefulWidget {
  @override
  _BookingScreenState createState() => _BookingScreenState();
}

String formatDate(DateTime date) {
  return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
}

class _BookingScreenState extends State<BookingScreen> {
  CollectionReference bookingsCollection = FirebaseFirestore.instance.collection('bookings');
  CollectionReference availabilityCollection = FirebaseFirestore.instance.collection('homestay_availability');

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileController = TextEditingController();

  String selectedHomestay = '';
  DateTime? checkInDate;
  DateTime? checkOutDate;
  bool isAvailable = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Booking Information',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.indigo[900],
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Name input with icon
              Row(
                children: [
                  Icon(Icons.person, color: Theme.of(context).primaryColor),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: 'Name',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),

              // Email input with icon
              Row(
                children: [
                  Icon(Icons.email, color: Theme.of(context).primaryColor),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),

              // Phone Number input with icon
              Row(
                children: [
                  Icon(Icons.phone, color: Theme.of(context).primaryColor),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: TextFormField(
                      controller: mobileController,
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),

              // Homestay selection
              Text(
                'Select Homestay:',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              Column(
                children: [
                  for (var homestay in [
                    'Angsana House',
                    'Apsara Villa',
                    'Chenang Stay',
                    'Indah Home',
                    'Dini Pavi'
                  ])
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 8.0),
                      padding: EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: Colors.indigo[100], // Light blue background color
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: RadioListTile<String>(
                        title: Text(
                          homestay,
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        value: homestay,
                        groupValue: selectedHomestay,
                        onChanged: (value) {
                          setState(() {
                            selectedHomestay = value!;
                          });
                        },
                      ),
                    ),
                ],
              ),
              SizedBox(height: 16.0),

              // Date selection
              Text(
                'Select Dates:',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      final DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(Duration(days: 365)),
                      );
                      if (pickedDate != null && pickedDate != checkInDate) {
                        setState(() {
                          checkInDate = pickedDate;
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.indigo[900], // Dark blue background color
                    ),
                    child: Text(
                      'Check-in Date',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(Duration(days: 365)),
                      );
                      if (pickedDate != null && pickedDate != checkOutDate) {
                        setState(() {
                          checkOutDate = pickedDate;
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.indigo[900], // Dark blue background color
                    ),
                    child: Text(
                      'Check-out Date',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),

              // Selected dates display
              if (checkInDate != null && checkOutDate != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Selected Dates: Check-in - ${formatDate(checkInDate!)} | Check-out - ${formatDate(checkOutDate!)}',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    SizedBox(height: 16.0),

                    // Calendar display with availability status
                    buildCalendarDisplay(),
                  ],
                ),

              SizedBox(height: 16.0),

              // "Check Availability" button
              ElevatedButton(
                onPressed: () async {
                  await checkAvailability(); // Check availability when the button is pressed
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.indigo[900], // Dark blue background color
                ),
                child: Text(
                  'Check Availability',
                  style: TextStyle(color: Colors.white),
                ),
              ),

              SizedBox(height: 16.0),

              // "Next" button
              ElevatedButton(
                onPressed: isAvailable
                    ? () async {
                        // Create a map with booking information
                        Map<String, dynamic> bookingData = {
                          'name': nameController.text,
                          'email': emailController.text,
                          'phone': mobileController.text,
                          'homestay': selectedHomestay,
                          'checkInDate': checkInDate,
                          'checkOutDate': checkOutDate,
                        };

                        // Add the booking to Firestore
                        await bookingsCollection.add(bookingData);

                        // Update availability in Firestore
                        await updateAvailability();

                        // Navigate to the confirmation page with user input
                        Navigator.pushNamed(
                          context,
                          '/confirmation',
                          arguments: {
                            'name': nameController.text,
                            'email': emailController.text,
                            'phone': mobileController.text,
                            'homestay': selectedHomestay,
                            'checkInDate': checkInDate,
                            'checkOutDate': checkOutDate,
                          },
                        );
                      }
                    : null, // Disable the button if not available
                style: ElevatedButton.styleFrom(
                  primary: Colors.indigo[900], // Dark blue background color
                ),
                child: Text(
                  'Next',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCalendarDisplay() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Calendar:',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Table(
            children: [
              TableRow(
                children: [
                  for (int i = 0; i < 7; i++) buildTableCell(getDayAbbreviation(i + 1)),
                ],
              ),
              TableRow(
                children: [
                  for (int i = 1; i <= 7; i++) buildEmptyTableCell(),
                ],
              ),
              TableRow(
                children: [
                  for (int i = 1; i <= 7; i++) buildEmptyTableCell(),
                ],
              ),
              TableRow(
                children: [
                  for (int i = 1; i <= 7; i++) buildEmptyTableCell(),
                ],
              ),
              TableRow(
                children: [
                  for (int i = 1; i <= 7; i++) buildEmptyTableCell(),
                ],
              ),
              TableRow(
                children: [
                  for (int i = 1; i <= 7; i++) buildEmptyTableCell(),
                ],
              ),
              TableRow(
                children: [
                  for (int i = 1; i <= 7; i++) buildEmptyTableCell(),
                ],
              ),
              TableRow(
                children: [
                  for (int i = 1; i <= 7; i++) buildEmptyTableCell(),
                ],
              ),
              TableRow(
                children: [
                  for (int i = 1; i <= 7; i++) buildEmptyTableCell(),
                ],
              ),
              TableRow(
                children: [
                  for (int i = 1; i <= 7; i++) buildEmptyTableCell(),
                ],
              ),
              TableRow(
                children: [
                  for (int i = 1; i <= 7; i++) buildEmptyTableCell(),
                ],
              ),
              TableRow(
                children: [
                  for (int i = 1; i <= 7; i++) buildEmptyTableCell(),
                ],
              ),
              TableRow(
                children: [
                  for (int i = 1; i <= 7; i++) buildDateCell(checkInDate!.add(Duration(days: i - checkInDate!.weekday))),
                ],
              ),
              TableRow(
                children: [
                  for (int i = 1; i <= 7; i++) buildDateCell(checkInDate!.add(Duration(days: 7 + i - checkInDate!.weekday))),
                ],
              ),
              TableRow(
                children: [
                  for (int i = 1; i <= 7; i++) buildDateCell(checkInDate!.add(Duration(days: 14 + i - checkInDate!.weekday))),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildTableCell(String day) {
    return TableCell(
      child: Container(
        padding: EdgeInsets.all(8.0),
        color: Colors.grey,
        child: Text(
          day,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget buildEmptyTableCell() {
    return TableCell(
      child: Container(
        padding: EdgeInsets.all(8.0),
        color: Colors.grey,
        child: Text(
          '',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget buildDateCell(DateTime date) {
    return TableCell(
      child: GestureDetector(
        onTap: () async {
          bool isAvailable = await isDateAvailable(date);
          if (!isAvailable) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('This date is unavailable for booking.'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: Container(
          padding: EdgeInsets.all(8.0),
          color: Colors.green, // Adjust the color as needed
          child: Text(
            date.day.toString(),
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  String getDayAbbreviation(int day) {
    switch (day) {
      case 1:
        return 'Sun';
      case 2:
        return 'Mon';
      case 3:
        return 'Tue';
      case 4:
        return 'Wed';
      case 5:
        return 'Thu';
      case 6:
        return 'Fri';
      case 7:
        return 'Sat';
      default:
        return '';
    }
  }

  Future<bool> isDateAvailable(DateTime date) async {
    if (selectedHomestay.isNotEmpty && date != false) {
      final availabilitySnapshot = await availabilityCollection
          .doc(selectedHomestay)
          .collection(formatDate(date))
          .doc('availability')
          .get();

      bool isAvailable =
          availabilitySnapshot.exists ? availabilitySnapshot['available'] ?? false : false;

      if (!isAvailable) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('The date ${formatDate(date)} is not available for booking.'),
            backgroundColor: Colors.red,
          ),
        );
      }

      return isAvailable;
    }

    return true;
  }

  Future<void> checkAvailability() async {
    if (selectedHomestay.isNotEmpty && checkInDate != null) {
      final availabilitySnapshot = await availabilityCollection
          .doc(selectedHomestay)
          .collection(formatDate(checkInDate!))
          .doc('availability')
          .get();

      setState(() {
        isAvailable = availabilitySnapshot.exists ? availabilitySnapshot['available'] ?? false : false;
      });
    }
  }

  Future<void> updateAvailability() async {
    if (selectedHomestay.isNotEmpty && checkInDate != null) {
      await availabilityCollection
          .doc(selectedHomestay)
          .collection(formatDate(checkInDate!))
          .doc('availability')
          .set({'available': false});
    }
  }
}

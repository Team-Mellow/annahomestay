import 'package:flutter/material.dart';
import 'package:annahomestay/mainpage.dart';
import 'package:annahomestay/signup.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Homestay App'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Image.asset(
            //   'assets/homestay_logo.png', // Add your logo asset
            //   height: 100,
            // ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to the list of available homestays
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomestayListPage()),
                );
              },
              child: Text('Explore Homestays'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to the user's booked homestays
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BookedHomestaysPage()),
                );
              },
              child: Text('Your Bookings'),
            ),
          ],
        ),
      ),
    );
  }
}

class HomestayListPage extends StatelessWidget {
  // Dummy data for demonstration purposes
  final List<Homestay> homestays = [
    Homestay(
        'Beautiful Cottage', 'City Center', '200/night', 'assets/cottage.jpg'),
    Homestay(
        'Modern Apartment', 'Suburb Area', '180/night', 'assets/apartment.jpg'),
    Homestay('Cozy Cabin', 'Mountain View', '300/night', 'assets/cabin.jpg'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Available Homestays'),
      ),
      body: ListView.builder(
        itemCount: homestays.length,
        itemBuilder: (context, index) {
          return HomestayCard(homestay: homestays[index]);
        },
      ),
    );
  }
}

class Homestay {
  final String name;
  final String location;
  final String price;
  final String imagePath;

  Homestay(this.name, this.location, this.price, this.imagePath);
}

class HomestayCard extends StatelessWidget {
  final Homestay homestay;

  HomestayCard({required this.homestay});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset(
            homestay.imagePath,
            height: 150,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  homestay.name,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  homestay.location,
                  style: TextStyle(fontSize: 14.0),
                ),
                Text(
                  homestay.price,
                  style: TextStyle(fontSize: 14.0),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Implement logic to book the homestay
              // This could involve navigating to a booking page or showing a dialog
              // For demonstration purposes, we'll print a message to the console
              print('Book ${homestay.name}');
            },
            child: Text('Book Now'),
          ),
        ],
      ),
    );
  }
}

class BookedHomestaysPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Implement the UI for displaying the user's booked homestays
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Bookings'),
      ),
      body: Center(
        child: Text('Your Booked Homestays'),
      ),
    );
  }
}

import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Homestay App',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: HomePage(),
//     );
//   }
// }

class HomePage extends StatelessWidget {
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
            Image.asset(
              'assets/homestay_logo.png', // Add your logo asset
              height: 100,
            ),
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
  @override
  Widget build(BuildContext context) {
    // Implement the UI for displaying a list of available homestays
    return Scaffold(
      appBar: AppBar(
        title: Text('Available Homestays'),
      ),
      body: Center(
        child: Text('List of Homestays'),
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

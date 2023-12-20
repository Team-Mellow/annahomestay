import 'package:annahomestay/customer/bookingscreen.dart';
import 'package:flutter/material.dart';

class ListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.home), // Flutter house icon
            SizedBox(width: 8.0),
            Text('List of Homestays'),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'ANNA HOMESTAY',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              primary: Colors.white,
              backgroundColor: Colors.orange[300],
            ),
            onPressed: () {
              MaterialPageRoute route =
                  MaterialPageRoute(builder: (context) => BookingScreen());
              Navigator.push(context, route);
            },
            child: Row(
              children: [
                Icon(Icons.book),
                SizedBox(width: 8.0),
                Text('BOOK NOW'),
              ],
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: HomestayRow(
                homestays: [
                  {'name': 'Angsana House', 'color': Colors.red},
                  {'name': 'Apsara Villa', 'color': Colors.red},
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: HomestayRow(
                homestays: [
                  {'name': 'Chenang Stay', 'color': Colors.blue},
                  {'name': 'Indah Home', 'color': Colors.blue},
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: HomestayRow(
                homestays: [
                  {'name': 'Dini Pavi', 'color': Colors.green},
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomestayRow extends StatelessWidget {
  final List<Map<String, dynamic>> homestays;

  HomestayRow({required this.homestays});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: homestays.map((homestay) {
        return GestureDetector(
          onTap: () {
            print("Homestay ${homestay['name']} clicked");
          },
          child: Container(
            margin: const EdgeInsets.all(8.0),
            width: 200,
            height: 160, // Increased height to accommodate the image
            decoration: BoxDecoration(
              color: homestay['color'],
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3), // changes the shadow position
                ),
              ],
            ),
            child: Center(
              child: Text(
                homestay['name'],
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

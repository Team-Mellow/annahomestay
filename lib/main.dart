import 'package:flutter/material.dart';

void main() {
  runApp(Tab1());
}

class Tab1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppBar(
              title: Text('Homestays'),
              actions: [
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    // Handle search action
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle book now action
                  },
                  child: Text('BOOK NOW'),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/anna-homestay.jpeg',
                    height: 50.0,
                    width: 50.0,
                  ),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          // Handle date action
                        },
                        child: Text('Date'),
                      ),
                      TextButton(
                        onPressed: () {
                          // Handle time action
                        },
                        child: Text('Time'),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: Icon(Icons.menu),
                    onPressed: () {
                      // Handle menu action
                    },
                  ),
                ],
              ),
            ),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                _buildHomestayItem('Angsana House', 'resources/homestay1.jpg'),
                _buildHomestayItem('Apsara Villa', 'resources/homestay2.jpg'),
                _buildHomestayItem('Chenang Stay', 'resources/homestay3.jpg'),
                _buildHomestayItem('Indah Home', 'resources/homestay4.jpeg'),
                _buildHomestayItem('Dini Pavi', 'resources/homestay5.jpg'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHomestayItem(String title, String imagePath) {
    return Card(
      child: Column(
        children: [
          Image.asset(
            imagePath,
            height: 150.0,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(title),
          ),
        ],
      ),
    );
  }
}

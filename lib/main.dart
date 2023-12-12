import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Homestay List',
      initialRoute: '/',
      routes: {
        '/': (context) => Scaffold(
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
                      backgroundColor: Colors.blue,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/confirmation');
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
            ),
        '/confirmation': (context) => ConfirmationPage(),
      },
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
            color: homestay['color'],
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

class ConfirmationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Confirmation'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Name: John Doe'),
            ),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text('Phone Number: +1 123-456-7890'),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Homestay Chosen: Angsana House'),
            ),
            ListTile(
              leading: Icon(Icons.calendar_today),
              title: Text('Date Check-in: 2023-05-01'),
            ),
            ListTile(
              leading: Icon(Icons.calendar_today),
              title: Text('Date Check-out: 2023-05-07'),
            ),
            ListTile(
              leading: Icon(Icons.attach_money),
              title: Text('Price: \$500.00'),
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            width: 16.0,
          ),
          ElevatedButton(
            onPressed: () {
              // Add your cancel logic here
              print("Booking Canceled!");
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            child: Container(
              width: 70,
              child: Center(
                child: Text('CANCEL'),
              ),
            ),
          ),
          SizedBox(
            width: 16.0,
          ),
          ElevatedButton(
            onPressed: () {
              // Add your confirmation logic here
              print("Booking Confirmed!");
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            child: Container(
              width: 70,
              child: Center(
                child: Text('CONFIRM'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

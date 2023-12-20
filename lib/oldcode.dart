import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Homestay List',
      initialRoute: '/',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.indigo[900],
        ),
      ),
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
                      backgroundColor: Colors.orange[300],
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/booking');
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
        '/booking': (context) => BookingPage(),
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

class BookingPage extends StatefulWidget {
  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  String formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  String selectedHomestay = '';
  DateTime? checkInDate;
  DateTime? checkOutDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Information'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Name'),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(labelText: 'Phone Number'),
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
                    RadioListTile<String>(
                      title: Text(homestay),
                      value: homestay,
                      groupValue: selectedHomestay,
                      onChanged: (value) {
                        setState(() {
                          selectedHomestay = value!;
                        });
                      },
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
                    child: Text('Check-in Date'),
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
                    child: Text('Check-out Date'),
                  ),
                ],
              ),
              SizedBox(height: 16.0),

              // Selected dates display
              if (checkInDate != null && checkOutDate != null)
                Text(
                  'Selected Dates: Check-in - ${formatDate(checkInDate!)} | Check-out - ${formatDate(checkOutDate!)}',
                  style: TextStyle(fontSize: 16.0),
                ),

              SizedBox(height: 16.0),

              // "Next" button
              ElevatedButton(
                onPressed: () {
                  print('Selected Homestay: $selectedHomestay');
                  print('Check-in Date: $checkInDate');
                  print('Check-out Date: $checkOutDate');
                  Navigator.pushNamed(context, '/confirmation');
                },
                child: Text('Next'),
              ),
            ],
          ),
        ),
      ),
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

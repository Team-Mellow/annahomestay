import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Homestay List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomestayList(),
    );
  }
}

class HomestayList extends StatelessWidget {
  // List of homestays
  final List<String> homestays = [
    'Angsana House',
    'Apsara Villa',
    'Chenang Stay',
    'Indah Home',
    'Dini Pavi',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Homestay List'),
      ),
      body: ListView.builder(
        itemCount: homestays.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(homestays[index]),
          );
        },
      ),
    );
  }
}

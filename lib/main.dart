import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Homestay List',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Homestay List'),
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
        return Container(
          margin: const EdgeInsets.all(8.0),
          width: 200,
          height: 100,
          color: homestay['color'],
          child: Center(
            child: Text(
              homestay['name'],
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ),
        );
      }).toList(),
    );
  }
}

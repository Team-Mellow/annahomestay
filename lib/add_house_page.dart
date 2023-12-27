// Import necessary packages and files
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'screen1.dart';

class AddHousePage extends StatefulWidget {
  const AddHousePage({Key? key}) : super(key: key);

  @override
  _AddHousePageState createState() => _AddHousePageState();
}

class _AddHousePageState extends State<AddHousePage> {
  late TextEditingController nameController;
  late TextEditingController categoryController;
  late TextEditingController priceController;
  late TextEditingController capacityController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    categoryController = TextEditingController();
    priceController = TextEditingController();
    capacityController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    categoryController.dispose();
    priceController.dispose();
    capacityController.dispose();
    super.dispose();
  }

  Future<void> insertHouseData(House house) async {
    try {
      final CollectionReference homestayCollection =
          FirebaseFirestore.instance.collection('Homestay');

      await homestayCollection.add({
        'name': house.name,
        'category': house.category,
        'price': house.price,
        'capacity': house.capacity,
      });

      // Print the entered data
      print('House data inserted successfully!');
      print('Name: ${house.name}');
      print('Category: ${house.category}');
      print('Price: ${house.price}');
      print('Capacity: ${house.capacity}');

      // Navigate to HomestayFilter.dart
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomestayFilter()),
      );
    } catch (e) {
      print('Error inserting house data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New House'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: categoryController,
              decoration: InputDecoration(labelText: 'Category'),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Price'),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: capacityController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Capacity'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Add new house data to Firestore
                final newHouse = House(
                  name: nameController.text,
                  category: categoryController.text,
                  price: double.parse(priceController.text),
                  capacity: int.parse(capacityController.text),
                );

                insertHouseData(newHouse);
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
              ),
              child: Text('Add House'),
            ),
            const SizedBox(height: 16.0),
            // New button to navigate to screen1.dart
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomestayFilter()),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
              ),
              child: Text('Go to Screen1'),
            ),
          ],
        ),
      ),
    );
  }
}

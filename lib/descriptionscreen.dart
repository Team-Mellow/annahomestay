import 'package:flutter/material.dart';
import 'homestay_model.dart';

class DescriptionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Homestay homestay =
        ModalRoute.of(context)!.settings.arguments as Homestay;

    return Scaffold(
      appBar: AppBar(
        title: Text('Homestay Details'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Centered House Name as a title with cursive font
              Text(
                homestay.houseName,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Pacifico', // Set the cursive font
                ),
              ),
              SizedBox(height: 16.0),

              // Other details
              Text('Category: ${homestay.category}'),
              Text('Capacity: ${homestay.capacity}'),
              Text('Price: ${homestay.price}'),
              // Add more details as needed
            ],
          ),
        ),
      ),
    );
  }
}

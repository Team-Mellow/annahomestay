import 'package:flutter/material.dart';

class ManageProperty extends StatefulWidget {
  const ManageProperty({Key? key}) : super(key: key);

  @override
  State<ManageProperty> createState() => _ManagePropertyState();
}

class _ManagePropertyState extends State<ManageProperty> {
  // Dummy data for homestay listings
  List<HomestayListing> homestayListings = [
    HomestayListing(
      title: 'Cozy Cottage',
      location: 'Mountain View, CA',
      price: '\$120/night',
      imageUrl: 'assets/cozy_cottage.jpg',
    ),
    HomestayListing(
      title: 'Beachfront Paradise',
      location: 'Malibu, CA',
      price: '\$200/night',
      imageUrl: 'assets/beachfront_paradise.jpg',
    ),
    HomestayListing(
      title: 'Urban Retreat',
      location: 'New York, NY',
      price: '\$180/night',
      imageUrl: 'assets/urban_retreat.jpg',
    ),
    HomestayListing(
      title: 'Rustic Cabin',
      location: 'Aspen, CO',
      price: '\$150/night',
      imageUrl: 'assets/rustic_cabin.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Property'),
      ),
      body: ListView.builder(
        itemCount: homestayListings.length,
        itemBuilder: (context, index) {
          return HomestayCard(homestay: homestayListings[index]);
        },
      ),
    );
  }
}

class HomestayListing {
  final String title;
  final String location;
  final String price;
  final String imageUrl;

  HomestayListing({
    required this.title,
    required this.location,
    required this.price,
    required this.imageUrl,
  });
}

class HomestayCard extends StatelessWidget {
  final HomestayListing homestay;

  const HomestayCard({Key? key, required this.homestay}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            homestay.imageUrl,
            width: double.infinity,
            height: 200,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  homestay.title,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(homestay.location),
                SizedBox(height: 8.0),
                Text(homestay.price),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

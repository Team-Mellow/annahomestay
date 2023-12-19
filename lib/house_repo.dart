import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class House {
  final String? id;
  final String name;
  final String category;
  final double price;
  final int capacity;

  House({
    this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.capacity,
  });

  toJson() {
    return {
      "HouseName": name,
      "Category": category,
      "Price": price,
      "Capacity": capacity,
    };
  }

  //map house fetched from firebase to housemodel
  factory House.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return House(
        id: document.id,
        name: data["HouseName"],
        category: data["Category"],
        price: data["Price"],
        capacity: data["Capacity"]);
  }
}

class HouseRepository extends GetxController {
  static HouseRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

//store house in FireStore
  createHouse(House house) async {
    await _db.collection("Houses").add(house.toJson()).whenComplete(() =>
        Get.snackbar("Success", "A house has been created",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green.withOpacity(0.1),
            colorText: Colors.green));
  }

  //fetch all house or house details

  Future<House> allHouse() async {
    final snapshot = await _db.collection("Houses").get();
    final houseData = snapshot.docs.map((e) => House.fromSnapshot(e)).single;
    return houseData;
  }
}

class HomestayFilter extends StatefulWidget {
  const HomestayFilter({super.key});

  @override
  State<HomestayFilter> createState() => _HomestayFilterState();
}

class _HomestayFilterState extends State<HomestayFilter> {
  final List<House> houses = [
    House(name: 'Angsana House', category: 'Standard', price: 100, capacity: 2),
    House(name: 'Indah Home', category: 'Deluxe', price: 200, capacity: 4),
    House(name: 'Apsara Villa', category: 'Standard', price: 150, capacity: 2),
    House(name: 'Chenang Stay', category: 'Landed', price: 300, capacity: 6),
  ];

  String filter = '';
  String selectedCategory = 'All';
  String sortOrder = 'asc';
  String sortType = 'price';
  int? numberOfPeople;
  List<House> filteredHouses = [];

  void handleFilter() {
    filteredHouses = houses
        .where(
          (house) =>
              (selectedCategory == 'All' ||
                  house.category == selectedCategory) &&
              (numberOfPeople == null || house.capacity >= numberOfPeople!),
        )
        .toList();

    filteredHouses.sort((a, b) {
      if (sortType == 'price') {
        // Sort by price
        final priceComparison = a.price.compareTo(b.price);

        // Adjust based on sortOrder
        return sortOrder == 'asc' ? priceComparison : -priceComparison;
      }
      return 0;
    });
  }

  void toggleSortOrder() {
    setState(() {
      sortOrder = sortOrder == 'asc' ? 'desc' : 'asc';
    });
  }

  void handleSortTypeChange(String type) {
    setState(() {
      sortType = type;
    });

    // Reset sortOrder to 'asc' when changing sortType
    setState(() {
      sortOrder = 'asc';
    });
  }

  void handleSearch() {
    handleFilter();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Homestay Filter'),
        backgroundColor: Colors.brown, // Change the app bar color
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DropdownButton<String>(
                  value: selectedCategory,
                  onChanged: (value) {
                    setState(() {
                      selectedCategory = value!;
                    });
                  },
                  items:
                      ['All', 'Standard', 'Deluxe', 'Landed'].map((category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Filter by number of people',
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  onChanged: (value) {
                    setState(() {
                      numberOfPeople =
                          value.isNotEmpty ? int.parse(value) : null;
                    });
                  },
                ),
                const SizedBox(height: 16.0),
                // New Row for Toggle and Price buttons
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: toggleSortOrder,
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(
                              255, 189, 134, 53), // Change the button color
                        ),
                        child: Text('Toggle Price Order ($sortOrder)'),
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => handleSortTypeChange('price'),
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(
                              255, 189, 134, 53), // Change the button color
                        ),
                        child: Text(
                            'Price ${sortType == 'price' ? '($sortOrder)' : ''}'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: handleSearch,
                  style: ElevatedButton.styleFrom(
                    primary: Colors.greenAccent, // Change the button color
                  ),
                  child: Text('Search'),
                ),
                const SizedBox(height: 16.0),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: filteredHouses.length,
                  itemBuilder: (context, index) {
                    final house = filteredHouses[index];
                    return Card(
                      elevation: 3.0,
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ListTile(
                        title: Text(house.name),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Category: ${house.category}'),
                            Text('Price: RM${house.price}'),
                            Text('Capacity: ${house.capacity} person(s)'),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

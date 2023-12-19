import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class House {
  final String name;
  final String category;
  final double price;
  final int capacity;

  House({
    required this.name,
    required this.category,
    required this.price,
    required this.capacity,
  });
}

class HomestayFilter extends StatefulWidget {
  const HomestayFilter({Key? key}) : super(key: key);

  @override
  _HomestayFilterState createState() => _HomestayFilterState();
}

class _HomestayFilterState extends State<HomestayFilter> {
  final List<House> houses = [];
  String filter = '';
  String selectedCategory = 'All';
  String sortOrder = 'asc';
  String sortType = 'price';
  int? numberOfPeople;
  List<House> filteredHouses = [];

  Future<void> getHouseData() async {
    final QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('Homestay').get();

    houses.clear();

    snapshot.docs.forEach((document) {
      final data = document.data() as Map<String, dynamic>;
      final house = House(
        name: data['name'] ?? '',
        category: data['category'] ?? '',
        price: (data['price'] ?? 0).toDouble(),
        capacity: data['capacity'] ?? 0,
      );

      houses.add(house);
    });

    handleFilter();
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

      print('House data inserted successfully!');
    } catch (e) {
      print('Error inserting house data: $e');
    }
  }

  void handleFilter() {
    filteredHouses = houses.where(
      (house) =>
          (selectedCategory == 'All' || house.category == selectedCategory) &&
          (numberOfPeople == null || house.capacity >= numberOfPeople!),
    ).toList();

    filteredHouses.sort((a, b) {
      if (sortType == 'price') {
        final priceComparison = a.price.compareTo(b.price);
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

    setState(() {
      sortOrder = 'asc';
    });
  }

  void handleSearch() {
    handleFilter();
  }

  @override
  void initState() {
    super.initState();
    getHouseData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Homestay Filter'),
        backgroundColor: Colors.brown,
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
                  items: ['All', 'Standard', 'Deluxe', 'Landed'].map((category) {
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
                      numberOfPeople = value.isNotEmpty ? int.parse(value) : null;
                    });
                  },
                ),
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: toggleSortOrder,
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 189, 134, 53),
                        ),
                        child: Text('Toggle Price Order ($sortOrder)'),
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => handleSortTypeChange('price'),
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 189, 134, 53),
                        ),
                        child: Text('Price ${sortType == 'price' ? '($sortOrder)' : ''}'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: handleSearch,
                  style: ElevatedButton.styleFrom(
                    primary: Colors.greenAccent,
                  ),
                  child: Text('Search'),
                ),
                const SizedBox(height: 16.0),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: filteredHouses.length,
                  itemBuilder: (context, index) {
                    final house = filteredHouses[index];
                    return GestureDetector(
                      onTap: () {
                        // Handle the onTap action, for example, navigate to a detail screen.
                        // You can replace this with your desired behavior.
                        print('Item clicked: ${house.name}');
                      },
                      child: Card(
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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Insert a new house data before running the app
  House newHouse = House(
    name: 'Indah Home',
    category: 'Deluxe',
    price: 150.0,
    capacity: 6,
  );

  await insertHouseData(newHouse);

  runApp(MaterialApp(
    home: HomestayFilter(),
  ));
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

    print('House data inserted successfully!');
  } catch (e) {
    print('Error inserting house data: $e');
  }
}

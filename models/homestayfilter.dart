import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../repository/homestay_repository.dart'; // Adjust this import path to your HomestayRepository
import 'homestay.dart'; // Adjust this import path to your Homestay model

class HomestayFilterPage extends StatelessWidget {
  final HomestayRepository _controller = Get.put(HomestayRepository());
  final TextEditingController _capacityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Homestay Filter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Filter by Category:',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            buildCategoryDropdown(), // Build the dropdown with 'All' option
            SizedBox(height: 16),
            TextField(  // Capacity input field
              controller: _capacityController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter capacity',
                hintText: 'e.g., 4',
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                int? capacity = int.tryParse(_capacityController.text); // Parse the capacity input
                if (capacity != null) {
                  _controller.selectedCapacity.value = capacity;  // Update the selected capacity
                  _controller.fetchFilteredHomestays();  // Now fetch the filtered homestays
                } else {
                  // Handle the case where the input is not a valid integer
                  print("Please enter a valid capacity");
                }
              },
              child: Text('Filter'),
            ),
            SizedBox(height: 16),
            Obx(() {
              if (_controller.filteredHomestays.isEmpty) {
                return Text('No homestays found.');
              } else {
                return Expanded(
                  child: ListView.builder(
                    itemCount: _controller.filteredHomestays.length,
                    itemBuilder: (context, index) {
                      Homestay homestay = _controller.filteredHomestays[index];
                      return ListTile(
                        title: Text(homestay.houseName),
                        subtitle: Text('${homestay.category} - Capacity: ${homestay.capacity}'),
                        trailing: Text('\$${homestay.price.toString()}'),
                        leading: Image.network(homestay.imageUrl, fit: BoxFit.cover),
                      );
                    },
                  ),
                );
              }
            }),
          ],
        ),
      ),
    );
  }

  // Build the category dropdown with proper handling for 'All' and uninitialized lists
  Widget buildCategoryDropdown() {
    return Obx(() {
      List<String> allCategories = ['All', ..._controller.categories.where((c) => c != 'All')];
      if (allCategories.isEmpty) {
        return CircularProgressIndicator(); // Show a loading indicator or some placeholder
      } else {
        if (!allCategories.contains(_controller.selectedCategory.value)) {
          _controller.selectedCategory.value = 'All'; // Default to 'All'
        }

        return DropdownButton<String>(
          value: _controller.selectedCategory.value,
          onChanged: (newValue) {
            _controller.selectedCategory.value = newValue ?? 'All';
          },
          items: allCategories.map((category) {
            return DropdownMenuItem(
              child: Text(category),
              value: category,
            );
          }).toList(),
        );
      }
    });
  }
}

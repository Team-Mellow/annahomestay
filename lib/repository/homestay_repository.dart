import 'package:annahomestay/models/homestay.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/booking_model.dart';


class HomestayRepository extends GetxController {
  static HomestayRepository get instance => Get.put(HomestayRepository());
  RxList<Homestay> filteredHomestays = <Homestay>[].obs;
  RxString selectedCategory = 'All'.obs;
  RxDouble selectedPrice = 0.0.obs;
  RxInt selectedCapacity = 0.obs;
  RxInt capacity = 0.obs;

  List<String> categories = ['All','Standard', 'Bungalow', 'Deluxe'];

  final _db = FirebaseFirestore.instance;
// final CollectionReference bookingsCollection = FirebaseFirestore.instance.collection('bookings'); // Define bookings collection

  void fetchFilteredHomestays() async {
    try {

     // double? price = selectedPrice.value;  // Use the value of selectedPrice or a default value if it's null
    //  double? queryPrice = (price != null && price > 0.0) ? price : null;
        double? price = selectedPrice.value > 0.0 ? selectedPrice.value : null;
      List<Homestay> homestays = await getFilteredHomestays(
        category: selectedCategory.value != 'All' ? selectedCategory.value : null, // Fetch all if 'All' is selected
        price: price ,
        capacity: selectedCapacity.value,
      );

      if (homestays.isNotEmpty) {
        filteredHomestays.value = homestays;
      } else {
        filteredHomestays.clear();
      }
    } catch (error) {
      print('Error fetching filtered homestays: $error');
    }
  }


  //final _db = FirebaseFirestore.instance;

  //store homestay in FireStore
  createHomestay(Homestay homestay) async {
    try {
      await _db.collection("Homestay2").add(homestay.toJson());
    } catch (error) {
      Get.snackbar(
        "Error",
        "Something went wrong. Try again",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent.withOpacity(0.1),
        colorText: Colors.red,
      );
      print("ERROR - $error");
    }
  }

  //fetch homestay details
  Future<void> getHouseData() async {
    final QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection('Homestay2').get();
  }

  Future<List<Homestay>> getAllHomestayDetails() async {
    final snapshot = await _db.collection("Homestay2").get();
    final homestayData =
        snapshot.docs.map((e) => Homestay.fromSnapshot(e)).toList();
    return homestayData;
  }

  Future<void> updateHomestay(Homestay updatedHomestay) async {
    try {
      await _db.collection('Homestay2').doc(updatedHomestay.id).update(
            updatedHomestay.toJson(),
          );
    } on FirebaseException catch (e) {
      throw e.message ?? 'Something went wrong.';
    } catch (e) {
      throw 'Something went wrong.';
    }
  }

  Future<void> removeHomestay(Homestay homestay) async {
    try {
      final homestayRef = _db.collection('Homestay2').doc(homestay.id);
      await homestayRef.delete();
    } catch (e) {
      throw 'Something went wrong';
    }
  }

  // Fetch homestay details with optional filters
 Future<List<Homestay>> getFilteredHomestays({String? category, double? price, int? capacity}) async {
  Query query = _db.collection("Homestay2"); // Adjust your Firestore collection name as needed

  if (category != null && category.isNotEmpty) {
    query = query.where('Category', isEqualTo: category); // Match field name with Firestore
  }
  if (price != null && price > 0) {
    query = query.where('Price', isLessThanOrEqualTo: price); // Match field name with Firestore
  }
  if (capacity != null && capacity > 0) {
    query = query.where('Capacity', isGreaterThanOrEqualTo: capacity); // allow to display if capacity less then max
  }

  QuerySnapshot snapshot = await query.get();
  return snapshot.docs.map((e) => Homestay.fromSnapshot(e)).toList();
}

 // Inside homestay_repository.dart  // for availability 

Future<List<Map<String, dynamic>>> fetchHomestayDetails() async {
  try {
    final snapshot = await _db.collection("Homestay2").get();
    final homestayDetails = snapshot.docs.map((doc) {
      return {
        'HouseName': doc.get('HouseName'),
        'Price': doc.get('Price'),
        'Capacity': doc.get('Capacity'),
      };
    }).toList();
    return homestayDetails;
  } catch (e) {
    throw 'Error fetching homestay details: $e';
  }
  
}



  Future<List<String>> fetchHomestayNames() async {
    try {
      final snapshot = await _db.collection("Homestay2").get();
      final homestayNames =
          snapshot.docs.map((e) => e.get('HouseName')).toList();
      return homestayNames.cast<String>();
    } catch (e) {
      throw 'Error fetching homestay names: $e';
    }
  
}


}


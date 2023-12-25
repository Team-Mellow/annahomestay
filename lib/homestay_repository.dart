// homestay_repository.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'homestay_model.dart';

class HomestayRepository extends GetxController {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  static HomestayRepository get instance => Get.put(HomestayRepository());

  Future<List<HomestayModel>> getHomestays() async {
    try {
      QuerySnapshot querySnapshot = await _db.collection('homestays').get();
      return querySnapshot.docs
          .map((doc) =>
              HomestayModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (error) {
      print('Error fetching homestays: $error');
      return [];
    }
  }
}

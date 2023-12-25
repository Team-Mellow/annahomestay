import 'package:annahomestay/homestay.dart';
import 'package:annahomestay/repository/homestay_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomestayController extends GetxController {
  static HomestayController get instance => Get.find();

  final name = TextEditingController();
  final capacity = TextEditingController();
  final category = TextEditingController();
  final price = TextEditingController();
  final imageUrl = TextEditingController();

  final homestayRepo = Get.put(HomestayRepository());

  Future<void> createHomestay(Homestay homestay) async {
    await homestayRepo.createHomestay(homestay);
  }

  getAllHomestayDetails() {
    return homestayRepo.getAllHomestayDetails();
  }

  Future<void> removeHomestay(Homestay homestayId) async {
    try {
      await homestayRepo.removeHomestay(homestayId);
      update();
    } catch (e) {
      throw 'Something went wrong';
    }
  }
}

import 'dart:io';
import 'dart:js_util';

import 'package:annahomestay/controller/propertyController.dart';
import 'package:annahomestay/models/homestay.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ManageProperty2 extends StatefulWidget {
  const ManageProperty2({super.key});

  @override
  State<ManageProperty2> createState() => _ManageProperty2State();
}

class _ManageProperty2State extends State<ManageProperty2> {
  final controller = Get.put(HomestayController2());
  final CollectionReference _items =
      FirebaseFirestore.instance.collection('Homestay2');
  String imageUrl = '';
  Future<void> _create([DocumentSnapshot? documentSnapshot]) async {
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                right: 20,
                left: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(child: Text('Add Homestay')),
                TextField(
                  controller: controller.name,
                  decoration: const InputDecoration(labelText: 'House Name'),
                ),
                TextField(
                  controller: controller.capacity,
                  decoration: const InputDecoration(labelText: 'Capacity'),
                ),
                TextField(
                  controller: controller.category,
                  decoration: const InputDecoration(labelText: 'Category'),
                ),
                TextField(
                  controller: controller.price,
                  decoration: const InputDecoration(labelText: 'Price'),
                ),
                TextField(
                  controller: controller.imageUrl,
                  decoration: const InputDecoration(labelText: 'Image Url'),
                ),
                const SizedBox(
                  height: 10,
                ),
                IconButton(
                    onPressed: () async {
                      final file = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);
                      if (file == null) {
                        return;
                      }
                      String fileName =
                          DateTime.now().microsecondsSinceEpoch.toString();

                      Reference referenceRoot = FirebaseStorage.instance.ref();
                      Reference referenceDireImages =
                          referenceRoot.child('images');
                      Reference referenceImageToUpload =
                          referenceDireImages.child(fileName);

                      try {
                        await referenceImageToUpload.putFile(File(file.path));

                        imageUrl =
                            await referenceImageToUpload.getDownloadURL();
                      } catch (error) {
                        //some error
                      }
                    },
                    icon: const Icon(Icons.camera_alt)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                        onPressed: () async {
                          if (imageUrl.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        "Please select and upload image")));
                            return;
                          }
                          // Validate and add homestay to the list
                          if (controller.name.text.isNotEmpty &&
                              controller.capacity.text.isNotEmpty &&
                              controller.category.text.isNotEmpty &&
                              controller.price.text.isNotEmpty) {
                            setState(() {
                              final homestay = Homestay(
                                  houseName: controller.name.text.trim(),
                                  category: controller.category.text.trim(),
                                  capacity: int.parse(controller.capacity.text),
                                  price: double.parse(controller.price.text),
                                  imageUrl: imageUrl);

                              HomestayController2.instance
                                  .createHomestay(homestay);
                            });
                            Navigator.pop(context); // Close the dialog
                          }
                        },
                        child: const Text('Add')),
                  ],
                )
              ],
            ),
          );
        });
  }

  late Stream<QuerySnapshot> _stream;
  @override
  void initState() {
    super.initState();
    _stream = FirebaseFirestore.instance.collection('Homestay2').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Property'),
        backgroundColor: Colors.deepPurple[200],
        elevation: 0,
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: _stream,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('Some error occured${snapshot.error}'),
              );
            }

            if (snapshot.hasData) {
              QuerySnapshot querySnapshot = snapshot.data;
              List<QueryDocumentSnapshot> document = querySnapshot.docs;

              List<Map> items = document.map((e) => e.data() as Map).toList();

              return ListView.builder(
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index) {
                  Map thisItems = items[index];
                  return Card(
                    elevation: 2.0,
                    margin: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Text(
                        "${thisItems['HouseName']}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ), // Adjusted for case sensitivity
                      // Add other widgets or customize the Card as needed
                    ),
                  );
                },
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _create();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

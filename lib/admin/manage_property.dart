import 'package:annahomestay/controller/manageProperty_controller.dart';
import 'package:flutter/material.dart';
import 'package:annahomestay/models/homestay.dart';
import 'package:get/get.dart';

class ManageProperty extends StatefulWidget {
  const ManageProperty({Key? key}) : super(key: key);

  @override
  State<ManageProperty> createState() => _ManagePropertyState();
}

class _ManagePropertyState extends State<ManageProperty> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomestayController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Property'),
        backgroundColor: Colors.deepPurple[200],
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                AlertDialog alertDialog = AlertDialog(
                  title: const Text('Add Homestay'),
                  content: Column(
                    children: [
                      TextField(
                        controller: controller.name,
                        decoration:
                            const InputDecoration(labelText: 'House Name'),
                      ),
                      TextField(
                        controller: controller.capacity,
                        decoration:
                            const InputDecoration(labelText: 'Capacity'),
                      ),
                      TextField(
                        controller: controller.category,
                        decoration:
                            const InputDecoration(labelText: 'Category'),
                      ),
                      TextField(
                        controller: controller.price,
                        decoration: const InputDecoration(labelText: 'Price'),
                      ),
                      TextField(
                        controller: controller.imageUrl,
                        decoration:
                            const InputDecoration(labelText: 'Image URL'),
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context); // Close the dialog
                      },
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        // Validate and add homestay to the list
                        if (controller.name.text.isNotEmpty &&
                            controller.capacity.text.isNotEmpty &&
                            controller.category.text.isNotEmpty &&
                            controller.price.text.isNotEmpty &&
                            controller.imageUrl.text.isNotEmpty) {
                          setState(() {
                            final homestay = Homestay(
                                houseName: controller.name.text.trim(),
                                category: controller.category.text.trim(),
                                capacity: int.parse(controller.capacity.text),
                                price: double.parse(controller.price.text),
                                imageUrl: controller.imageUrl.text.trim());

                            HomestayController.instance
                                .createHomestay(homestay);
                          });
                          Navigator.pop(context); // Close the dialog
                        }
                      },
                      child: const Text('Add'),
                    ),
                  ],
                );
                showDialog(
                    context: context,
                    builder: (context) {
                      return alertDialog;
                    });
              },
              icon: Icon(Icons.add)),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: FutureBuilder<List<Homestay>>(
              future: controller.getAllHomestayDetails(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  //Homestay homestayData = snapshot.data as Homestay;
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (c, index) {
                      return SizedBox(
                        width: 100,
                        child: Card(
                          margin: const EdgeInsets.all(20),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              //mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  snapshot.data![index].imageUrl,
                                  width: double.infinity,
                                  height: 200,
                                  fit: BoxFit.cover,
                                ),
                                Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        snapshot.data![index].houseName,
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 8.0),
                                      Text('Capacity: ' +
                                          snapshot.data![index].capacity
                                              .toString()),
                                      SizedBox(height: 8.0),
                                      Text('Price: RM' +
                                          snapshot.data![index].price
                                              .toString()),
                                      SizedBox(height: 8.0),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          TextButton(
                                            onPressed: () {
                                              // setState(() {
                                              //   final homestay =
                                              //       snapshot.data![index];
                                              //   controller
                                              //       .removeHomestay(homestay);
                                              // });
                                              AlertDialog alertDialog =
                                                  AlertDialog(
                                                title:
                                                    const Text('Edit Homestay'),
                                                content: Column(
                                                  children: [
                                                    TextField(
                                                      controller:
                                                          TextEditingController(
                                                              text: snapshot
                                                                  .data![index]
                                                                  .houseName),
                                                      decoration:
                                                          const InputDecoration(
                                                              labelText:
                                                                  'House Name'),
                                                    ),
                                                    TextField(
                                                      controller:
                                                          TextEditingController(
                                                              text: snapshot
                                                                  .data![index]
                                                                  .capacity
                                                                  .toString()),
                                                      decoration:
                                                          const InputDecoration(
                                                              labelText:
                                                                  'Capacity'),
                                                    ),
                                                    TextField(
                                                      controller:
                                                          TextEditingController(
                                                              text: snapshot
                                                                  .data![index]
                                                                  .category),
                                                      decoration:
                                                          const InputDecoration(
                                                              labelText:
                                                                  'Category'),
                                                    ),
                                                    TextField(
                                                      controller:
                                                          TextEditingController(
                                                              text: snapshot
                                                                  .data![index]
                                                                  .price
                                                                  .toString()),
                                                      decoration:
                                                          const InputDecoration(
                                                              labelText:
                                                                  'Price'),
                                                    ),
                                                    TextField(
                                                      controller:
                                                          TextEditingController(
                                                              text: snapshot
                                                                  .data![index]
                                                                  .imageUrl),
                                                      decoration:
                                                          const InputDecoration(
                                                              labelText:
                                                                  'Image URL'),
                                                    ),
                                                  ],
                                                ),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(
                                                          context); // Close the dialog
                                                    },
                                                    child: const Text('Cancel'),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      // Validate and update homestay in the list
                                                      if (controller.name
                                                              .text.isNotEmpty &&
                                                          controller.capacity.text
                                                              .isNotEmpty &&
                                                          controller.category.text
                                                              .isNotEmpty &&
                                                          controller.price.text
                                                              .isNotEmpty &&
                                                          controller
                                                              .imageUrl
                                                              .text
                                                              .isNotEmpty) {
                                                        setState(() {
                                                          final homestay =
                                                              Homestay(
                                                            houseName:
                                                                controller
                                                                    .name.text
                                                                    .trim(),
                                                            category: controller
                                                                .category.text
                                                                .trim(),
                                                            capacity: int.parse(
                                                                controller
                                                                    .capacity
                                                                    .text),
                                                            price: double.parse(
                                                                controller.price
                                                                    .text),
                                                            imageUrl: controller
                                                                .imageUrl.text
                                                                .trim(),
                                                          );

                                                          // Assuming you have a method to update homestay in the controller
                                                          controller
                                                              .updateHomestay(
                                                                  homestay);
                                                        });
                                                        Navigator.pop(
                                                            context); // Close the dialog
                                                      }
                                                    },
                                                    child: const Text('Update'),
                                                  ),
                                                ],
                                              );

                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return alertDialog;
                                                  });
                                            },
                                            child: Text(
                                              'Edit',
                                              style: TextStyle(
                                                color: Colors.blue,
                                              ),
                                              //textAlign: TextAlign.end,
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              setState(() {
                                                final homestay =
                                                    snapshot.data![index];
                                                controller
                                                    .removeHomestay(homestay);
                                              });
                                            },
                                            child: Text(
                                              'Remove',
                                              style: TextStyle(
                                                color: Colors.red,
                                              ),
                                              //textAlign: TextAlign.end,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ]),
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              }),
        ),
      ),
    );
  }
}

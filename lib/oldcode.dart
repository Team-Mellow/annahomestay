import 'package:flutter/material.dart';
import 'homestay_repository.dart';
import 'homestay_model.dart';

class ListScreen extends StatelessWidget {
  final HomestayRepository _homestayRepository = HomestayRepository.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo[900],
        title: Row(
          children: [
            Icon(
              Icons.home,
              color: Colors.white,
            ),
            SizedBox(width: 8.0),
            Text(
              'List of Homestays',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'ANNA HOMESTAY',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              primary: Colors.orange[700],
              backgroundColor: Colors.indigo[900],
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/booking');
            },
            child: Row(
              children: [
                Icon(Icons.book),
                SizedBox(width: 8.0),
                Text('BOOK NOW'),
              ],
            ),
          ),
        ],
      ),
      body: FutureBuilder<List<Homestay>>(
        future: _homestayRepository.getAllHomestayDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Text('No homestay data available.');
          } else {
            List<Homestay> homestays = snapshot.data!;
            return ListView.builder(
              itemCount: homestays.length,
              itemBuilder: (context, index) {
                return HomestayRow(homestay: homestays[index]);
              },
            );
          }
        },
      ),
    );
  }
}

class HomestayRow extends StatelessWidget {
  final Homestay homestay;

  HomestayRow({required this.homestay});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/description',
          arguments: homestay,
        );
      },
      child: Container(
        margin: const EdgeInsets.all(8.0),
        width: 200,
        height: 160,
        decoration: BoxDecoration(
          color: homestay.category == 'A'
              ? Colors.red[200]
              : homestay.category == 'B'
                  ? Colors.orange[200]
                  : homestay.category == 'C'
                      ? Colors.blue[200]
                      : homestay.category == 'D'
                          ? Colors.purple[200]
                          : Colors.green[200],
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: Text(
            homestay.houseName,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

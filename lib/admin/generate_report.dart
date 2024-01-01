import 'package:flutter/material.dart';

class GenerateReport extends StatefulWidget {
  const GenerateReport({super.key});

  @override
  State<GenerateReport> createState() => _GenerateReportState();
}

class _GenerateReportState extends State<GenerateReport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Generate Report'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 200,
              height: 50,
              child: TextButton(
                child: Text('General Report'),
                onPressed: () {},
                style: TextButton.styleFrom(
                    backgroundColor: Colors.deepPurple[50]),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 200,
              height: 50,
              child: TextButton(
                child: Text('Individual Homestay Report'),
                onPressed: () {},
                style: TextButton.styleFrom(
                    backgroundColor: Colors.deepPurple[50]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

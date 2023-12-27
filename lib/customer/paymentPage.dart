import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
enum CardType { visa, mastercard }

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

  class _PaymentScreenState extends State<PaymentScreen> {
  TextEditingController cardNumberController = TextEditingController();
  DateTime? expiryDate;
  TextEditingController cvvController = TextEditingController();
  TextEditingController cardHolderNameController = TextEditingController();
  CardType selectedCardType = CardType.visa; // Default to Visa

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
         backgroundColor: Colors.brown,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButton<CardType>(
              value: selectedCardType,
              onChanged: (CardType? value) {
                setState(() {
                  selectedCardType = value!;
                });
              },
              items: CardType.values.map((CardType type) {
                return DropdownMenuItem<CardType>(
                  value: type,
                  child: Text(
                    type == CardType.visa ? 'Visa' : 'MasterCard',
                    style: TextStyle(fontSize: 16.0),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: cardNumberController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Card Number',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    readOnly: true,
                    onTap: () {
                      _selectExpiryDate(context);
                    },
                    controller: expiryDate == null
                        ? TextEditingController(text: '')
                        : TextEditingController(
                            text: '${expiryDate!.month}/${expiryDate!.year}',
                          ),
                    decoration: InputDecoration(
                      labelText: 'Expiry Date',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 16.0),
                Expanded(
                  child: TextField(
                    controller: cvvController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'CVV',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: cardHolderNameController,
              decoration: InputDecoration(
                labelText: 'Cardholder Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                // Handle payment confirmation
                _showConfirmationDialog();
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
                padding: EdgeInsets.symmetric(vertical: 16.0),
              ),
              child: Text(
                'Confirm Payment',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Show a simple payment confirmation dialog
  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Payment Successful'),
          content: Text(
            'Thank you ${cardHolderNameController.text} for your payment with ${selectedCardType == CardType.visa ? 'Visa' : 'MasterCard'}! ',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _selectExpiryDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 10),
    );

    if (picked != null && picked != expiryDate) {
      setState(() {
        expiryDate = picked;
      });
    }
  }
}

import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  const ButtonWidget({
    super.key,
    required this.text,
    required this.onClicked,
  });

  @override
  Widget build(BuildContext context) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: const Color.fromARGB(255, 245, 228, 71),
          shape: const StadiumBorder(),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
        ),
        onPressed: onClicked,
        child: Text(text),
      );
}

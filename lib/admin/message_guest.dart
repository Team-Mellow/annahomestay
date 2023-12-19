import 'package:flutter/material.dart';

class MessageGuest extends StatefulWidget {
  const MessageGuest({super.key});

  @override
  State<MessageGuest> createState() => _MessageGuestState();
}

class _MessageGuestState extends State<MessageGuest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Guest Message'),
      ),
      body: Text('Message with Guest'),
    );
  }
}

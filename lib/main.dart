import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'screen2.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyCJd8beOBOV1U5Dnx-S3XwooYVOxY9KSe4",
        appId: "1:425277120843:web:6d9cbdcc261924acd608ce",
        messagingSenderId: "425277120843",
        projectId: "annahomestay-ea338",
      ),
    );
  }
  await Firebase.initializeApp();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key); // Remove 'super.key' if not needed

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: PaymentScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

import 'package:annahomestay/admin/dashboard.dart';
import 'package:annahomestay/loginPage/signup.dart';
import 'package:annahomestay/loginPage/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'mainpage.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   Firebase.initializeApp();
//   runApp(const SignupPage());
// }

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyCJd8beOBOV1U5Dnx-S3XwooYVOxY9KSe4",
            appId: "1:425277120843:web:6d9cbdcc261924acd608ce",
            messagingSenderId: "425277120843",
            projectId: "annahomestay-ea338"));
  }
  await Firebase.initializeApp();
  //final storage = FirebaseStorage.instanceFor(bucket: "gs://annahomestay-ea338.appspot.com");

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: AdminDashboard(), //nanti tukar balik jadi SignUpPage()
      debugShowCheckedModeBanner: false,
    );
  }
}

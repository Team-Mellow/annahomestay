import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:annahomestay/page/profile_page.dart';
import 'package:annahomestay/utils/user_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyCJd8beOBOV1U5Dnx-S3XwooYVOxY9KSe4",
      appId: "1:425277120843:web:6d9cbdcc261924acd608ce",
      messagingSenderId: "425277120843",
      projectId: "annahomestay-ea338",
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static const String title = 'User Profile';

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const user = UserPreferences.myUser;

    return const MaterialApp(
      title: 'Anna HomeStay',
      home: ProfilePage(),
    );
  }
}

import 'package:annahomestay/login.dart';
import 'package:annahomestay/signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'paymentScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Stripe.publishableKey =
  //     "pk_test_51OSXWiIvbkIA9TsRLG51JJv3aXAV3gLIYaak2VShii8Ji84BLjJArJoDdiMPcUZNCKDh7RumdJi1RBmE56FpABEY00P8U6aBZr";

  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyCJd8beOBOV1U5Dnx-S3XwooYVOxY9KSe4",
            appId: "1:425277120843:web:6d9cbdcc261924acd608ce",
            messagingSenderId: "425277120843",
            projectId: "annahomestay-ea338"));
  }

  await Firebase.initializeApp();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: //PaymentScreen(),
          LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

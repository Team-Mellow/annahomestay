import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:annahomestay/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:annahomestay/page/profile_page.dart';

import 'package:annahomestay/utils/user_preferences.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static const String title = 'User Profile';

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const user = UserPreferences.myUser;

    return ThemeProvider(
        initTheme: user.themes ? MyThemes.darkTheme : MyThemes.lightTheme,
        builder: (context, myTheme) {
          return MaterialApp(
            title: 'Anna HomeStay',
            theme: myTheme,
            home: const ProfilePage(),
          );
        });
  }
}

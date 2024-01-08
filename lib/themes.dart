import 'package:flutter/material.dart';

class MyThemes {
  static const primary = Colors.white;
  static const primaryColor = Colors.white;

  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade900,
    primaryColorDark: primaryColor,
    colorScheme: const ColorScheme.dark(primary: primary),
    dividerColor: Colors.black,
  );

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
    primaryColor: primaryColor,
    colorScheme: const ColorScheme.light(primary: primary),
    dividerColor: Colors.black,
  );
}

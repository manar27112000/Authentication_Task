import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    primaryColor: Colors.purple,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Color(0xff151515),
  cardColor: Colors.black,
  appBarTheme: AppBarTheme(
   // backgroundColor: darkSurface,
    foregroundColor: Colors.white,
    elevation: 0,
  ),
  textTheme: const TextTheme(
  //  bodyMedium: TextStyle(color: darkTextColor),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.purple,
      foregroundColor: Colors.white,
    ),
  ),
);
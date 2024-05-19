import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  appBarTheme: const AppBarTheme(
    centerTitle: true,
    backgroundColor: Colors.white,
    titleTextStyle: TextStyle(
        color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
    iconTheme: IconThemeData(color: Color(0xFF831216)),
  ),
  primaryColor: const Color(0xFF831216),
  colorScheme: const ColorScheme.light(
    background: Colors.white,
    primary: Color(0xFF831216),
    secondary: Color(0xFF831216),
    error: Color(0xFFB00020),
    onPrimary: Colors.black,
    onSecondary: Colors.black54,
    onTertiary: Colors.black45,
    onError: Colors.white,
  ),
);

import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  appBarTheme: const AppBarTheme(
    centerTitle: true,
    backgroundColor: Colors.white,
    titleTextStyle: TextStyle(
        color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
    iconTheme: IconThemeData(color: Color(0xFF831216)),
  ),
  colorScheme: const ColorScheme.dark(
    background: Color(0xFF121212),
    primary: Color(0xFF831216),
    secondary: Color(0xFF831216),
    error: Color(0xFFB00020),
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onError: Colors.white,
  ),
);

import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  appBarTheme: const AppBarTheme(
    centerTitle: true,
    backgroundColor: Color(0xFF212124),
    titleTextStyle: TextStyle(
        color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
    iconTheme: IconThemeData(color: Colors.white),
  ),
  colorScheme: const ColorScheme.dark(
    background: Color(0xFF212124),
    primary: Color(0xFF831216),
    secondary: Color(0xFF831216),
    error: Color(0xFFB00020),
    onPrimary: Colors.white,
    onSecondary: Colors.white60,
    onError: Colors.white,
  ),
);

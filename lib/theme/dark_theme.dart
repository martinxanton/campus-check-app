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
  primaryColor: ThemeData.dark().scaffoldBackgroundColor,
  colorScheme: ColorScheme.dark(
    background: const Color(0xFF2a2a2a),
    primary: ThemeData.dark().scaffoldBackgroundColor,
    secondary: const Color(0xFF831216),
    error: const Color(0xFFB00020),
    onPrimary: Colors.white,
    onSecondary: Colors.white60,
    onTertiary: Colors.white54,
    onError: Colors.white,
  ),
);

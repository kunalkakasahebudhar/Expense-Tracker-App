import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      scaffoldBackgroundColor: const Color(0xFF209E9F),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 48,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: const Color(0xFF209E9F),
      ),
    );
  }
}

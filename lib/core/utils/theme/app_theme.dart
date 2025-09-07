import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme => ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent, surface: Colors.white),
    // scaffoldBackgroundColor: Colors.white,
  );
}

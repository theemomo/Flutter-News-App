import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/core/utils/theme/app_colors.dart';

class AppTheme {
  static ThemeData get lightTheme => ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent, surface: Colors.white),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.grey,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
        borderSide: BorderSide.none,
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
        borderSide: const BorderSide(color: AppColors.red),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(overlayColor: WidgetStateProperty.all(Colors.transparent)),
    ),
    scaffoldBackgroundColor: Colors.white,
    textTheme: GoogleFonts.openSansTextTheme(),
  );
}

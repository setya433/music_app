// import 'package:flutter/material.dart';

// final ThemeData darkTheme = ThemeData(
//   brightness: Brightness.dark,
//   scaffoldBackgroundColor: const Color(0xFF0A0A12),
//   primaryColor: const Color(0xFF1E1E2F),
//   fontFamily: 'Roboto',
//   textTheme: const TextTheme(
//     headline1: TextStyle(
//       fontSize: 24,
//       fontWeight: FontWeight.bold,
//       color: Colors.white,
//     ),
//     bodyText1:TextStyle(
//       fontSize: 16,
//       color: Colors.white70,
//     ),
//     button: TextStyle(
//       fontSize: 16,
//       color: Colors.black,
//     ),
//   elevatedButtonTheme: ElevatedButtonThemeData(
//     style: ElevatedButton.styleFrom(
//       backgroundColor: Color(0xFF00FF85),
//       foregroundColor: Colors.black),
//       padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
//     )
//   ),

// );


import 'package:flutter/material.dart';

class AppColors {
  static const background = Color(0xFF0A0A12);
  static const accent = Color(0xFF00FF85);
  static const inputBackground = Color(0xFF1C1C2D);
  static const textPrimary = Colors.white;
  static const textSecondary = Color(0xFFAAAAAA);
}

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.background,
      primaryColor: AppColors.accent,
      fontFamily: 'Roboto',
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
        ),
        titleLarge: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          color: AppColors.textPrimary,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          color: AppColors.textSecondary,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.inputBackground,
        hintStyle: const TextStyle(color: AppColors.textSecondary),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.accent,
          foregroundColor: Colors.black,
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.accent,
          textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ),
      iconTheme: const IconThemeData(
        color: AppColors.accent,
      ),
    );
  }
}

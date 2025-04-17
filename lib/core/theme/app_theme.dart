import 'package:flutter/material.dart';

class AppThemeData {
  static ThemeData lightTheme = ThemeData(
        primarySwatch: Colors.blue,
        primaryColor:  const Color.fromARGB(255, 23, 105, 246),
        secondaryHeaderColor: const Color(0xFF3949AB),
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Roboto',
        textTheme: const TextTheme(
          headlineMedium: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A237E),
          ),
          titleLarge: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1A237E),
          ),
          bodyLarge: TextStyle(
            fontSize: 16,
            color: Colors.black87,
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
            color: Colors.black87,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 23, 105, 246),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
            // Integrate app bar theme into input decoration theme
    inputDecorationTheme: InputDecorationTheme(
      fillColor: Color(0x0F4A75E8) // 0F is the hex for 6% opacity
, // Match app bar background color
      filled: true,
      labelStyle: TextStyle(color: Colors.grey.shade500), // Match app bar text color
      hintStyle: TextStyle(color: Colors.grey.shade500), // Match app bar text color
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8), // Match app bar border radius
        borderSide: BorderSide(color: Colors.transparent, width: 1), // Match app bar border color
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.transparent, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.transparent, width: 2), // Match app bar primary color
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.transparent, width: 1), // Customize error border color
      ),
    ),
      );

}
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
        ),
      ),

      // Default text color (fallback when no style is specified)
      textTheme: const TextTheme(
        bodyMedium: TextStyle(fontFamily: 'Poppins', color: Colors.black),
      ),
    );
  }
}

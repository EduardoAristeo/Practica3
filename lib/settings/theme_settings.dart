import 'package:flutter/material.dart';

class ThemeSettings {
  static ThemeData lightTheme(){
    final theme =ThemeData.light();
    return theme.copyWith(
      scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
    );
     
  }

  static ThemeData darkTheme(){
    final theme = ThemeData.dark();
    return theme.copyWith();
  }

  static ThemeData customTheme() {
    return ThemeData(
      scaffoldBackgroundColor: Colors.orange[100],
      primaryColor: const Color.fromARGB(255, 170, 255, 203),
      brightness: Brightness.light,
    );
  }
  
}
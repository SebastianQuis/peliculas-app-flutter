import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color.fromARGB(255, 0, 180, 216);

  static final ThemeData lightTheme = ThemeData.light().copyWith(
    primaryColor: primary,

    appBarTheme: const AppBarTheme(
      color: primary,
      elevation: 0,
      centerTitle: true
    ),

  );

  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    primaryColor: primary,
    appBarTheme: const AppBarTheme(
      color: primary,
      elevation: 0
    ),
    
    scaffoldBackgroundColor: Colors.black54,

  );
  
}

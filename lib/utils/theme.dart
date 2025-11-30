import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.white,
  scaffoldBackgroundColor: Colors.white,

  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,      
    foregroundColor: Colors.black,     
    elevation: 0,                      
    titleTextStyle: TextStyle(         
      color: Colors.black,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(color: Colors.black),
  ),

  colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  useMaterial3: true,
  scaffoldBackgroundColor: Colors.black,

  cardColor: Colors.white,
  primaryColor: Colors.white,

  colorScheme: const ColorScheme.dark(
    primary: Colors.black87,      
    onPrimary: Colors.white,       
    surface: Colors.white,         
    onSurface: Colors.black,      
    background: Colors.black,      
    onBackground: Colors.white,    
  ),

  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.black87,   
    surfaceTintColor: Colors.black, 
    foregroundColor: Colors.white,     
    titleTextStyle: TextStyle(
     
      color: Colors.white,
      fontSize: 17,
      fontWeight: FontWeight.bold,
    ),
    toolbarTextStyle: TextStyle(

      color: Colors.white,
      fontSize: 18,
    ),
    iconTheme: IconThemeData(color: Colors.white),
  ),

  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.black),
    bodyMedium: TextStyle(color: Colors.black),
    titleLarge: TextStyle(color: Colors.black),
    titleMedium: TextStyle(color: Colors.black),
    headlineLarge: TextStyle(color: Colors.black),
    headlineMedium: TextStyle(color: Colors.black),
  ),
);

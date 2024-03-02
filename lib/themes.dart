import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constants.dart';

ThemeData lightTheme = ThemeData(
  primarySwatch: Colors.teal,
  textTheme: const TextTheme(
    displayMedium: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 20,
      color: Colors.black,
    ),
    displaySmall: TextStyle(
      fontSize: 15,
      color: Colors.grey,
    ),
  ),

  scaffoldBackgroundColor: Colors.white,

  appBarTheme: const AppBarTheme(
    //systemOverlayStyle: SystemUiOverlayStyle.dark,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
    backgroundColor: Colors.white,
    elevation: 0.0,
    titleSpacing: 8.0,
    titleTextStyle: TextStyle(
      color: Colors.teal,
      fontWeight: FontWeight.bold,
      fontSize: 20.0,
    ),
    iconTheme: IconThemeData(
      color: Colors.teal,
    ),
  ),

  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    backgroundColor: Colors.white,
    selectedItemColor: Colors.teal[300],
    selectedIconTheme: IconThemeData(
      color: Colors.teal[300],
    ),
    unselectedItemColor: Colors.grey,
    elevation: 20.0,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: defaultColor,
  ),
);

ThemeData darkTheme = ThemeData(
  primarySwatch: Colors.blueGrey,
  textTheme: const TextTheme(
    displayMedium: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 20,
      color: Colors.white,
    ),
    displaySmall: TextStyle(
      fontSize: 15,
      color: Colors.grey,
    ),
  ),

  scaffoldBackgroundColor: const Color(0xFF333739),

  appBarTheme: const AppBarTheme(
    //systemOverlayStyle: SystemUiOverlayStyle.dark,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Color(0xFF333739),
      statusBarIconBrightness: Brightness.light,
    ),
    backgroundColor: Color(0xFF333739),
    elevation: 0.0,
    titleSpacing: 8.0,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 20.0,
    ),
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
  ),

  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    backgroundColor: Color(0xFF333739),
    selectedItemColor: Colors.deepOrange,
    unselectedItemColor: Colors.grey,
    elevation: 20.0,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: defaultColor,
  ),
);

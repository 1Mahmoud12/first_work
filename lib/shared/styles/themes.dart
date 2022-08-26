import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:to_do_app/shared/styles/color.dart';

ThemeData lightTheme = ThemeData(
    primarySwatch: defaultColor,
    floatingActionButtonTheme:
        const FloatingActionButtonThemeData(backgroundColor: Colors.orangeAccent),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: Colors.blue,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.black),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark),
        backgroundColor: Colors.white,
        elevation: 0.0,
        titleTextStyle:  TextStyle(
            color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        iconTheme: IconThemeData(color: Colors.black)),
    textTheme: const TextTheme(
        bodyText1:  TextStyle(
            fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.black)),
    fontFamily: 'jannahFont'
);

ThemeData dark_theme = ThemeData(
    primarySwatch: defaultColor,
    floatingActionButtonTheme:
        const FloatingActionButtonThemeData(backgroundColor: defaultColor),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.grey[900],
      elevation: 50.0,
      unselectedItemColor: Colors.white,
      selectedItemColor: defaultColor,
      type:
          BottomNavigationBarType.fixed, //مهم جداااااااااااااااااااااااااااااا
    ),
    scaffoldBackgroundColor: Colors.black12,
    appBarTheme: const AppBarTheme(
        systemOverlayStyle:  SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.light),
        backgroundColor: Colors.black12,
        elevation: 0.0,
        titleTextStyle: TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        iconTheme: const IconThemeData(color: Colors.white)),
    textTheme: const TextTheme(
        bodyText1: TextStyle(
            fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.white)),
    fontFamily: 'jannahFont'
);

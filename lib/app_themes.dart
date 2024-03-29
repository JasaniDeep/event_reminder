import 'package:flutter/material.dart';

class AppThemes {
  static final lightMode = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    backgroundColor: Colors.white,
    primaryColor: Colors.green,
    brightness: Brightness.light,
    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black, width: 1),
        borderRadius: BorderRadius.circular(10.0),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black, width: 1),
        borderRadius: BorderRadius.circular(10.0),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red, width: 1),
        borderRadius: BorderRadius.circular(10.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.green, width: 1),
        borderRadius: BorderRadius.circular(10.0),
      ),
      hintStyle: TextStyle(color: Colors.grey),
      fillColor: Colors.white,
    ),
  );
  static final darkMode = ThemeData(
    scaffoldBackgroundColor: Color(0xff1f1f21),
    backgroundColor: Color(0xff1f1f21),
    primaryColor: Colors.black,
    brightness: Brightness.dark,
    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white, width: 1),
        borderRadius: BorderRadius.circular(10.0),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white, width: 1),
        borderRadius: BorderRadius.circular(10.0),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red, width: 1),
        borderRadius: BorderRadius.circular(10.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.green, width: 1),
        borderRadius: BorderRadius.circular(10.0),
      ),
      hintStyle: TextStyle(color: Colors.grey),
      fillColor: Color(0xff1f1f21),
    ),
  );
  TextStyle get subtitleStyle {
    return TextStyle(
      fontSize: 18,
      color: Colors.grey,
    );
  }

  TextStyle get titleStyle {
    return TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
  }

  TextStyle get dateStyle {
    return TextStyle(fontSize: 18, fontWeight: FontWeight.w500);
  }

  TextStyle get dayStyle {
    return TextStyle(fontSize: 12, fontWeight: FontWeight.w500);
  }

  TextStyle get monthStyle {
    return TextStyle(fontSize: 12, fontWeight: FontWeight.w500);
  }

  TextStyle get labelStyle {
    return TextStyle(fontSize: 16, fontWeight: FontWeight.w500);
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData globalTheme() => ThemeData(
      splashColor: Colors.white,
      colorScheme: ColorScheme.fromSwatch(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
      ).copyWith(secondary: Colors.amber),
      textTheme: const TextTheme(
        headline1: TextStyle(
            fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.black),
        headline5: TextStyle(
            fontSize: 25.0,
            color: Colors.amber),
        bodyText1: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple),
        bodyText2: TextStyle(
            fontSize: 17.0, fontWeight: FontWeight.bold, color: Colors.black),
      ),
    );

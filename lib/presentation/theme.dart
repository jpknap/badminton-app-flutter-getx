import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DeliveryColors {
  final purple = Color(0xFF5117AC);
  final gree = Color(0xFF20D0C4);
  final dark = Color(0xFF03091E);
  final grey = Color(0xFF212738);
  final ligthGrey = Color(0xFFBBBBBB);
  final veryLightGrey = Color(0xFFF3F3F3);
  final white = Color(0xFFFFFFFF);
  final pink = Color(0xFFF5638B);
}

final gradientBackground = [DeliveryColors().purple, DeliveryColors().gree];

final _border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(
      color: DeliveryColors().ligthGrey,
      width: 1,
      style: BorderStyle.solid,
    ));

final lightTheme = ThemeData(
    inputDecorationTheme: InputDecorationTheme(
        enabledBorder: _border,
        border: _border,
        iconColor: DeliveryColors().purple),
    textTheme: GoogleFonts.poppinsTextTheme().apply(
        bodyColor: DeliveryColors().purple,
        displayColor: DeliveryColors().purple));

final darkTheme = ThemeData(
    scaffoldBackgroundColor: DeliveryColors().dark,
    inputDecorationTheme: InputDecorationTheme(
        enabledBorder: _border,
        border: _border,
        hintStyle: TextStyle(color: DeliveryColors().white),
        iconColor: DeliveryColors().gree),
    textTheme: GoogleFonts.poppinsTextTheme().apply(
        bodyColor: DeliveryColors().gree, displayColor: DeliveryColors().gree));

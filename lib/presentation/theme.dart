import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DeliveryColors {
  final purple = Color(0xFF5117AC);
  final gree = Color(0xFF20D0C4);
  final greeDark = Color.fromARGB(255, 17, 120, 113);
  final dark = Color(0xFF03091E);
  final grey = Color(0xFF212738);
  final ligthGrey = Color(0xFFBBBBBB);
  final veryLightGrey = Color(0xFFF3F3F3);
  final white = Color(0xFFFFFFFF);
  final pink = Color(0xFFF5638B);
}

final gradientBackground = [
  DeliveryColors().purple,
  DeliveryColors().greeDark,
];

final _border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(
      color: DeliveryColors().ligthGrey,
      width: 1,
      style: BorderStyle.solid,
    ));

class ThemeApp {
  final lightTheme = ThemeData(
      appBarTheme: AppBarTheme(color: DeliveryColors().white),
      iconTheme: const IconThemeData(size: 30),
      inputDecorationTheme: InputDecorationTheme(
          enabledBorder: _border,
          border: _border,
          iconColor: DeliveryColors().purple),
      textTheme: GoogleFonts.poppinsTextTheme(
              TextTheme(titleLarge: TextStyle(fontSize: 25)))
          .apply(
              bodyColor: DeliveryColors().purple,
              displayColor: DeliveryColors().purple));

  final darkTheme = ThemeData(
      buttonTheme: ButtonThemeData(),
      canvasColor: DeliveryColors().dark,
      appBarTheme: AppBarTheme(color: DeliveryColors().grey),
      scaffoldBackgroundColor: DeliveryColors().dark,
      iconTheme: IconThemeData(size: 30, color: DeliveryColors().white),
      inputDecorationTheme: InputDecorationTheme(
          enabledBorder: _border,
          border: _border,
          hintStyle: TextStyle(color: DeliveryColors().white),
          iconColor: DeliveryColors().gree),
      textTheme: GoogleFonts.poppinsTextTheme(TextTheme(
              titleSmall: TextStyle(fontWeight: FontWeight.bold),
              titleMedium: TextStyle(fontSize: 20),
              titleLarge: TextStyle(fontSize: 25)))
          .apply(
              bodyColor: DeliveryColors().gree,
              displayColor: DeliveryColors().gree));
}

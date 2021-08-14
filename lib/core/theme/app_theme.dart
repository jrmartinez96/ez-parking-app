import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ez_parking_app/core/framework/colors.dart';
import 'package:ez_parking_app/core/framework/styles.dart';

// ignore: prefer_function_declarations_over_variables
final ezParkingAppTheme = (BuildContext context) => ThemeData(
      brightness: Brightness.light,
      primaryColor: primary,
      accentColor: primary,
      accentIconTheme: const IconThemeData(color: primaryIconColor),
      backgroundColor: Colors.white,
      scaffoldBackgroundColor: Colors.white,
      buttonTheme: const ButtonThemeData(buttonColor: primary),
      appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Colors.black),
          color: Colors.white,
          elevation: 0,
          brightness: Brightness.light),
      textTheme: TextTheme(
        headline1: GoogleFonts.poppins(textStyle: h1),
        headline2: GoogleFonts.poppins(textStyle: h2),
        headline3: GoogleFonts.poppins(textStyle: h3),
        headline4: GoogleFonts.poppins(textStyle: h4),
        headline5: GoogleFonts.poppins(textStyle: h5),
        bodyText1: GoogleFonts.poppins(textStyle: bodyText1),
        bodyText2: GoogleFonts.poppins(textStyle: bodyText2),
        button: GoogleFonts.poppins(textStyle: button),
      ),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: primary,
        selectionColor: primary,
        selectionHandleColor: primary,
      ),
      inputDecorationTheme: InputDecorationTheme(
        isCollapsed: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        filled: true,
        fillColor: inputTextFillColor,
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: greyColor,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.red,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.red,
          ),
        ),
        labelStyle: bodyText1,
        hintStyle: bodyText1.copyWith(color: hintColor),
        errorStyle: bodyText1.copyWith(color: Colors.red),
      ),
    );

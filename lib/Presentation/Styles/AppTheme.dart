import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tasks_management_system/Presentation/Styles/AppColors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: scaffoldLightColor,
    primaryColor: primaryLightColor,
    cardColor: cardLightBackgroundColor,
    iconTheme: IconThemeData(color: textFieldLightBorderColor),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.sp),
        borderSide: BorderSide(color: textFieldLightBorderColor, width: 1.sp),
      ),
      fillColor: Colors.white,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.sp),
        borderSide: BorderSide(color: textFieldLightBorderColor, width: 1.sp),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.sp),
        borderSide: BorderSide(color: textFieldLightBorderColor, width: 1.sp),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.sp),
        borderSide: BorderSide(color: Colors.red, width: 1.sp),
      ),
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(
        fontFamily: GoogleFonts.geist().fontFamily,
        color: largeTextLightColor,
      ),
      titleMedium: TextStyle(
        fontFamily: GoogleFonts.geist().fontFamily,
        color: mediumTextLightColor,
      ),
    ),
    buttonTheme: ButtonThemeData(buttonColor: primaryLightColor),
  );
  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: scaffoldDarkColor,
    primaryColor: primaryDarkColor,
    cardColor: cardDarkBackgroundColor,
    iconTheme: IconThemeData(color: blueDAE),
    textTheme: TextTheme(
      titleLarge: TextStyle(
        fontFamily: GoogleFonts.geist().fontFamily,
        color: blueDAE,
      ),
      titleMedium: TextStyle(
        fontFamily: GoogleFonts.geist().fontFamily,
        color: mediumTextDarkColor,
      ),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: primaryDarkColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.sp)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.sp),
        borderSide: BorderSide(color: blueDAE, width: 1.sp),
      ),
      fillColor: textFieldDarkColor,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.sp),
        borderSide: BorderSide(color: blueDAE, width: 1.sp),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.sp),
        borderSide: BorderSide(color: blueDAE, width: 1.sp),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.sp),
        borderSide: BorderSide(color: Colors.red, width: 1.sp),
      ),
    ),
  );
}



import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';



ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: HexColor('333739'),
  appBarTheme: AppBarTheme(
      backwardsCompatibility: false,
      titleSpacing: 20.0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: HexColor('333739'),
        statusBarIconBrightness: Brightness.light,
      ),
      backgroundColor: HexColor('333739'),
      elevation: 0.0,
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      titleTextStyle: const TextStyle(
        fontFamily:'Jannah',

        color: Colors.white,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      )


  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.orange,
    unselectedItemColor: Colors.grey,
    elevation: 20.0,
    backgroundColor: HexColor('333739'),
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    subtitle1: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
      color: Colors.white,
      height: 1.3,
    ),
  ),
  fontFamily:'Jannah',


);
ThemeData lightTheme = ThemeData(

  scaffoldBackgroundColor: Colors.white,
  snackBarTheme: const SnackBarThemeData(contentTextStyle: TextStyle(fontFamily: 'Tajawal')),
  appBarTheme: const AppBarTheme(
    titleSpacing: 20.0,
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
    backgroundColor: Colors.white,
    elevation: 0.0,
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    titleTextStyle: TextStyle(
      fontFamily:'Tajawal',
      color: Colors.black,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.orange,
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
    subtitle1: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
      color: Colors.black,
      height: 1.3,
    ),
  ),
  fontFamily:'Tajawal',

);

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mvvm_demo/resources/colors_manager.dart';


ThemeData darkTheme = ThemeData(
  cursorColor: ColorManager.white,
  scaffoldBackgroundColor: Colors.black,
backgroundColor: Colors.black,
  cardTheme:  CardTheme(
    color: HexColor('242424'),
  ),
  appBarTheme:  AppBarTheme(
      titleSpacing: 20.0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: HexColor('242424'),
        statusBarIconBrightness: Brightness.light,
      ),
      backgroundColor: Colors.black,
      elevation: 0.0,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      )


  ),
  iconTheme:IconThemeData(color: ColorManager.yellow),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: ColorManager.yellow,
    unselectedItemColor: Colors.grey,
    elevation: 20.0,
    backgroundColor: HexColor('070707'),
  ),
  textTheme: const TextTheme(
    headline4: TextStyle(
      color: Colors.white
    ),
    bodyText1: TextStyle(
      fontSize: 25.0,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
    bodyText2:TextStyle(
      fontSize: 15.0,
      color: Colors.white,
    ),
    subtitle1: TextStyle(
      fontSize: 15.0,
      color: Colors.white,
     // height: 1.3,
    ),
  ),
  primarySwatch: Colors.yellow,

);


ThemeData lightTheme = ThemeData(
  cursorColor: ColorManager.black,
  cardColor:Colors.white,
  backgroundColor: Colors.white,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    titleSpacing: 20.0,
    backwardsCompatibility: false,
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
    backgroundColor: Colors.white,
    elevation: 0.0,
    iconTheme: const IconThemeData(
      color: Colors.black,
    ),
    titleTextStyle: const TextStyle(
      fontFamily:'Jannah',
      color: Colors.black,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.black,
  ),
  textTheme: const TextTheme(
    headline4:  TextStyle(
        color: Colors.black
    ),
    bodyText1: TextStyle(
      fontSize: 25.0,
      fontWeight: FontWeight.w500,
      color: Colors.black,
    ),
    bodyText2:TextStyle(
      fontSize: 15.0,
      color: Colors.grey,
    ),
    subtitle1: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
      color: Colors.black,
      height: 1.3,
    ),
  ),
);


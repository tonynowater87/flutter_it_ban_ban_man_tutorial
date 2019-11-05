import 'package:flutter/material.dart';

final BlackTheme = ThemeData(
    primarySwatch: materialBlack,
    buttonTheme: ButtonThemeData(
        buttonColor: materialBlack, textTheme: ButtonTextTheme.primary),
    textTheme: TextTheme(
        display1: TextStyle(fontSize: 36, color: materialBlack.withOpacity(0.8))));

final BlueTheme = ThemeData(
  primarySwatch: Colors.blue,
  buttonTheme: ButtonThemeData(
      buttonColor: Colors.blue, textTheme: ButtonTextTheme.primary),
  textTheme: TextTheme(
      display1: TextStyle(fontSize: 36, color: Colors.blue.withOpacity(0.8))),
);

final BlueGreyTheme = ThemeData(
  primarySwatch: Colors.blueGrey,
  buttonTheme: ButtonThemeData(
      buttonColor: Colors.blueGrey, textTheme: ButtonTextTheme.primary),
  textTheme: TextTheme(
      display1: TextStyle(fontSize: 36, color: Colors.blueGrey.withOpacity(0.8))),
);

const MaterialColor materialBlack = MaterialColor(
  _blackPrimaryValue,
  <int, Color>{
    50: Color(0xFF000000),
    100: Color(0xFF000000),
    200: Color(0xFF000000),
    300: Color(0xFF000000),
    400: Color(0xFF000000),
    500: Color(_blackPrimaryValue),
    600: Color(0xFF000000),
    700: Color(0xFF000000),
    800: Color(0xFF000000),
    900: Color(0xFF000000),
  },
);
const int _blackPrimaryValue = 0xFF000000;

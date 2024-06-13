import 'package:bus_app/src/constants/colours.dart';
import 'package:bus_app/src/constants/sizes.dart';
import 'package:flutter/material.dart';

class TAppBarTheme{
  TAppBarTheme._();

  static const lightAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(color: tDarkColor, size: tDefaultSize),
    actionsIconTheme: IconThemeData(color: tDarkColor, size: tDefaultSize),
    titleTextStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color:tDarkColor),
  );
  static const darkAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(color: tDarkColor, size: tDefaultSize),
    actionsIconTheme: IconThemeData(color: tDarkColor, size: tDefaultSize),
    titleTextStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color:tDarkColor),
  );
}
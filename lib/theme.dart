import 'package:flutter/material.dart';
import 'package:final_mwinda_app/utils/colors.dart';
import 'package:final_mwinda_app/utils/utils.dart';

ThemeData buildThemeData(){
  final baseTheme = ThemeData(fontFamily: AvailableFonts.primaryFont);

  // return baseTheme.copyWith();
  return baseTheme.copyWith(
    primaryColor: Colors.lightBlue,
    primaryColorDark: primaryDark,
    primaryColorLight: primaryLight,
    scaffoldBackgroundColor: Colors.white,
    buttonColor: Colors.lightBlue,
    buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.accent),
    /*accentColor: Colors.lightBlueAccent,*/
    accentColor: secondaryColor,
  );
}
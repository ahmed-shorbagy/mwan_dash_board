import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xff009E4F);
const kItemBackGroundColor = Color(0xff1E1E1E);
const kItemTitleTextColor = Color(0xffB7B7B7);

class AppTheme {
  static final lightTheme = ThemeData(
    primaryColor: kPrimaryColor,
    brightness: Brightness.light,
  );
  static final darkTheme = ThemeData(
      primaryColor: kPrimaryColor,
      brightness: Brightness.dark,
      appBarTheme: AppBarTheme(backgroundColor: Colors.black),
      scaffoldBackgroundColor: Colors.black);
}

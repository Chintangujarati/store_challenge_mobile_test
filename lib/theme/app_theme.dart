import 'package:flutter/material.dart';

class MyTheme {
  static ThemeData lightTheme(BuildContext context) => ThemeData(
      primarySwatch: Colors.blue,
      appBarTheme: AppBarTheme(
          color: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: primaryColor)),
      textTheme: Theme.of(context).textTheme);

  static ThemeData darkTheme(BuildContext context) => ThemeData(
      brightness: Brightness.dark,
      appBarTheme: const AppBarTheme(
          color: Colors.black, iconTheme: IconThemeData(color: Colors.white)));

  static Color creamColor = const Color(0xfff5f5f5);
  static Color darkBlusishColor = const Color(0xff403b58);

  static Color primaryColor = const Color(0xffA37903);
  static Color bgColor = const Color(0xff2F58E2);
  static Color greyColor = const Color(0xffA2A3B9);
  static Color greenColor = const Color(0xff1AFF00);
  static Color redColor = const Color(0xffFF006F);
  static Color itemBgColor = const Color(0xffF0EBE3);
  static Color paymentLineGreyBorderColor = const Color(0xffE3E3E3);
  static Color buttonColor = const Color(0xff9B7232);
}

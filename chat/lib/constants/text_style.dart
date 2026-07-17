
import 'package:chat/constants/colors.dart';
import 'package:flutter/material.dart';

class MyTextStyles {
  MyTextStyles._();

  static const header = TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: MyColors.btnColor);
  static const header2 = TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: MyColors.btnColor);
  static const caption =
      TextStyle(fontSize: 23, fontWeight: FontWeight.normal, height: 2.5, color:MyColors.btnColor);
  static const button =
      TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: MyColors.secColor);
  static const appbar = TextStyle(
      fontSize: 19, fontWeight: FontWeight.normal, color:MyColors.btnColor);
  static const textfield = TextStyle(
      fontSize: 17, fontWeight: FontWeight.normal, color: MyColors.btnColor);

  static const small = TextStyle(
      fontSize: 14, fontWeight: FontWeight.normal, color: MyColors.btnColor);
  static const headline = TextStyle(
      fontSize: 16, fontWeight: FontWeight.normal, color: MyColors.btnColor);
  static const title =
      TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: MyColors.btnColor);

  static const chat =
      TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: MyColors.secColor);
}
import 'package:flutter/cupertino.dart';
class AppTextStyle {
  static AppTextStyle instance = AppTextStyle._init();

  AppTextStyle._init();

  final TextStyle h2Bold = TextStyle(
    fontSize: 40,
    fontWeight: FontWeight.w700,
  );

  final TextStyle h4Bold = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w700,
  );

  final TextStyle h5Bold = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
  );

  final TextStyle h6Bold = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
  );

  final TextStyle bodyXLarge = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
  );

  final TextStyle bodyMedium = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

}

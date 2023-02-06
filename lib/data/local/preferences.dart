import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tech_task/res/app_string.dart';

late SharedPreferences prefs;

Future<void> initSharedPreferences() async {
  prefs = await SharedPreferences.getInstance();
  await readModelFromSF(AppString.instance.cartList);
}

Future<bool> writeModelToSF(String key, dynamic value) async {
  return await prefs.setString(key, jsonEncode(value));
}

Future<dynamic> readModelFromSF(String key) async {
  return prefs.getString(key) != null
      ? jsonDecode(prefs.getString(key)!)
      : null;
}

Future<bool> deleteModelFromSF(String key) async {
  return await prefs.remove(key);
}


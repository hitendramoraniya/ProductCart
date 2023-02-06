import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tech_task/res/app_color.dart';
import 'package:tech_task/res/app_string.dart';
import 'package:tech_task/view/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(
      const MyApp(),
    );
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppString.instance.appName,
      theme: ThemeData(
        primaryColor: AppColors.primaryColor,
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

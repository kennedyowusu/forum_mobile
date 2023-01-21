import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_course/screens/splash.dart';
import 'theme/color.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.fade,
      title: 'Forum',
      theme: ThemeData(
        primaryColor: primary,
      ),
      home: SplashScreen(),
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:online_course/screens/root_app.dart';
import 'package:online_course/theme/color.dart';
import 'auth/login/login.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);

  final String? token = GetStorage().read('token');

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 2), () {
      token == null ? Get.offAll(() => LoginScreen()) : Get.offAll(() => HomeScreen());
    });
    return SafeArea(
      child: Scaffold(
        backgroundColor: primary,
        body: Center(
          child: CircleAvatar(
            radius: 100,
            backgroundColor: Colors.white,
            child: Text(
              'Evolved',
              style: TextStyle(
                color: primary,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

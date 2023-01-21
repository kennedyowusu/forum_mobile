import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_course/theme/color.dart';

import 'auth/login/login.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 2), () {
      Get.offAll(() => LoginScreen());
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

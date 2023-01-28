
import 'package:flutter/material.dart';
import 'package:online_course/theme/color.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_course/model/post.dart';
import 'package:online_course/screens/auth/post_details.dart';
import 'package:online_course/screens/root_app.dart';
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
      home: SinglePostScreen(
        post: Post(
          id: 1,
          title: "Hello",
          description: "Hey",
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          liked: null,
          likesCount: null,
          user: null,
          userId: null,
        ),
      ),
    );
  }
}

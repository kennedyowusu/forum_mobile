import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:online_course/screens/auth/login/login.dart';
import 'package:online_course/screens/root_app.dart';
import 'theme/color.dart';

main() async {
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final String? token = GetStorage().read('token');
  
  @override
  Widget build(BuildContext context) {
    
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.fade,
      title: 'Forum',
      theme: ThemeData(
        primaryColor: primary,
      ),
      home:  token == null ? LoginScreen() : HomeScreen()
    );
  }
}

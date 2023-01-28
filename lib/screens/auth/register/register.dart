import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_course/controller/authentication.dart';
import 'package:online_course/screens/auth/login/login.dart';
import 'package:online_course/theme/color.dart';
import 'package:online_course/widgets/button.dart';
import 'package:online_course/widgets/input_field.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final AuthenticationController _authenticationController =
      Get.put(AuthenticationController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * 0.06,
            ),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Evolved',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: primary,
                    ),
                  ),
                  SizedBox(height: 50),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Create an account',
                      style: TextStyle(
                        fontSize: 16,
                        color: textColor,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  InputField(
                    inputController: nameController,
                    hintText: 'Enter Full Name',
                    prefixIcon: Icons.person,
                    keyboardType: TextInputType.text,
                    obscureText: false,
                  ),
                  SizedBox(height: 10),
                  InputField(
                    inputController: usernameController,
                    hintText: 'Enter Username',
                    prefixIcon: Icons.person,
                    keyboardType: TextInputType.text,
                    obscureText: false,
                  ),
                  SizedBox(height: 10),
                  InputField(
                    inputController: emailController,
                    hintText: 'Enter Email Address',
                    prefixIcon: Icons.email,
                    keyboardType: TextInputType.emailAddress,
                    obscureText: false,
                  ),
                  SizedBox(height: 10),
                  InputField(
                    inputController: passwordController,
                    hintText: 'Enter Password',
                    prefixIcon: Icons.lock,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                  ),
                  SizedBox(height: 20),
                  Obx(() {
                    return _authenticationController.isLoading.value
                        ? CircularProgressIndicator(
                            color: primary,
                          )
                        : Button(
                            buttonText: 'Sign Up',
                            onPressed: () async {
                              await _authenticationController.registerUser(
                                name: nameController.text.trim(),
                                username: usernameController.text.trim(),
                                email: emailController.text.trim(),
                                password: passwordController.text.trim(),
                              );

                              emailController.clear();
                              passwordController.clear();
                              nameController.clear();
                              usernameController.clear();
                            },
                          );
                  }),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Already have an account ?',
              style: TextStyle(
                fontSize: 16,
                color: textColor,
              ),
            ),
            SizedBox(width: 10),
            GestureDetector(
              onTap: () {
                Get.to(
                  () => LoginScreen(),
                );
              },
              child: Text(
                'Sign In',
                style: TextStyle(
                  fontSize: 16,
                  color: primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}

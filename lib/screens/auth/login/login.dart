import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_course/controller/authentication.dart';
import 'package:online_course/screens/auth/register/register.dart';
import 'package:online_course/theme/color.dart';
import 'package:online_course/widgets/button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../widgets/input_field.dart';
import 'components/authentication_icon.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final AuthenticationController _authenticationController =
      Get.put(AuthenticationController());

  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
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
                        'Login to your account',
                        style: TextStyle(
                          fontSize: 16,
                          color: textColor,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    InputField(
                      inputController: usernameController,
                      hintText: 'Enter Username',
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
                    SizedBox(height: 10),
                    Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Forgot Password ?',
                        style: TextStyle(
                          fontSize: 16,
                          color: textColor,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Obx(
                      () {
                        return _authenticationController.isLoading.value
                            ? CircularProgressIndicator(
                                color: primary,
                              )
                            : Button(
                                buttonText: 'Login',
                                onPressed: () async {
                                  if (formKey.currentState!.validate()) {
                                    formKey.currentState!.save();
                                    await _authenticationController.loginUser(
                                      username: usernameController.text.trim(),
                                      password: passwordController.text.trim(),
                                    );
                                  }
                                },
                              );
                      },
                    ),
                    SizedBox(height: 20),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        'Or Login with',
                        style: TextStyle(
                          fontSize: 16,
                          color: textColor,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AuthenticationIcon(
                          icon: Icons.facebook,
                          color: Color(0Xff0e8ef1),
                        ),
                        SizedBox(width: 20),
                        AuthenticationIcon(
                          icon: FontAwesomeIcons.twitter,
                          color: Color(0xFF1d9bf0),
                        ),
                        SizedBox(width: 20),
                        AuthenticationIcon(
                          icon: FontAwesomeIcons.google,
                          color: Colors.red,
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Don\'t have an account ?',
              style: TextStyle(
                fontSize: 16,
                color: textColor,
              ),
            ),
            SizedBox(width: 10),
            GestureDetector(
              onTap: () {
                Get.to(
                  () => RegisterScreen(),
                );
              },
              child: Text(
                'Sign Up',
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

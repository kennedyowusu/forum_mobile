import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_course/controller/authentication.dart';
import 'package:online_course/screens/auth/login/login.dart';
import 'package:online_course/theme/color.dart';
import 'package:online_course/widgets/button.dart';
import 'package:online_course/widgets/input_field.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();

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
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        emailController.text = value!;
                      },
                    ),
                    SizedBox(height: 10),
                    InputField(
                      inputController: usernameController,
                      hintText: 'Enter Username',
                      prefixIcon: Icons.person,
                      keyboardType: TextInputType.text,
                      obscureText: false,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        emailController.text = value!;
                      },
                    ),
                    SizedBox(height: 10),
                    InputField(
                      inputController: emailController,
                      hintText: 'Enter Email Address',
                      prefixIcon: Icons.email,
                      keyboardType: TextInputType.emailAddress,
                      obscureText: false,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        emailController.text = value!;
                      },
                    ),
                    SizedBox(height: 10),
                    InputField(
                      inputController: passwordController,
                      hintText: 'Enter Password',
                      prefixIcon: Icons.lock,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        emailController.text = value!;
                      },
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
                                if (formKey.currentState!.validate()) {
                                  formKey.currentState!.save();
                                  await _authenticationController.registerUser(
                                    name: nameController.text.trim(),
                                    username: usernameController.text.trim(),
                                    email: emailController.text.trim(),
                                    password: passwordController.text.trim(),
                                  );

                                  // _authenticationController
                                  //     .registerUser(
                                  //   name: nameController.text.trim(),
                                  //   username: usernameController.text.trim(),
                                  //   email: emailController.text.trim(),
                                  //   password: passwordController.text.trim(),
                                  // )
                                  //     .then(
                                  //   (value) {
                                  //     if (value) {
                                  //       Get.offAll(
                                  //         () => LoginScreen(),
                                  //       );
                                  //     }
                                  //   },
                                  // );
                                }
                              },
                            );
                    }),
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

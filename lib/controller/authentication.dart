import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert' as convert;
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:online_course/screens/root_app.dart';
import 'package:online_course/services/endpoints.dart';

class AuthenticationController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final isLoading = false.obs;

  final RxString token = ''.obs;

  final localStorage = GetStorage();

  Future registerUser({
    required String name,
    required String username,
    required String email,
    required String password,
  }) async {
    Map<String, String> dataObject = {
      'name': name,
      'username': username,
      'email': email,
      'password': password,
    };

    try {
      isLoading(true);
      http.Response response = await http.post(
        Uri.parse('${BASE_URL}register'),
        headers: {
          'Accept': 'application/json',
        },
        body: convert.jsonEncode(dataObject),
      );
      if (response.statusCode == 201) {
        isLoading(false);

        token.value = json.decode(response.body)['token'];
        localStorage.write('token', token.value);

        Get.offAll(() => HomeScreen());

        debugPrint(
          '${json.decode(response.body)['message']}',
        );
      } else {
        isLoading(false);
      snackBarMessage(response);
      }
    } catch (e) {
      debugPrint('Registration failed $e');
    } finally {
      isLoading(false);
    }
  }

  
  Future loginUser({
    required String username,
    required String password,
  }) async {
    Map<String, String> dataObject = {
      'username': username,
      'password': password,
    };
    isLoading(true);
    try {
      http.Response response = await http.post(
        Uri.parse('${BASE_URL}login'),
        headers: {
          'Accept': 'application/json',
        },
        body: dataObject,
      );
      if (response.statusCode == 200) {
        isLoading(false);

        token.value = json.decode(response.body)['token'];
        localStorage.write('token', token.value);

        Get.offAll(() => HomeScreen());

        debugPrint(
          '${json.decode(response.body)['message']}',
        );
      } else {
        isLoading(false);
        debugPrint(
          '${json.decode(response.body)['message']}',
        );
        snackBarMessage(response);
      }
    } catch (e) {
      debugPrint('Registration failed $e');
    } finally {
      isLoading(false);
    }
  }
}

SnackbarController snackBarMessage(http.Response response) {
    return Get.snackbar(
        "Error Occurred",
        '${json.decode(response.body)['message']}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.black,
        colorText: Colors.white,
        margin: EdgeInsets.all(20),
        borderRadius: 10,
        isDismissible: true,
      );
  }

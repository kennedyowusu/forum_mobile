import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_course/model/comment.dart';

import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:online_course/model/user.dart';
import 'package:online_course/services/endpoints.dart';

class UserController extends GetxController {
  RxList<UserModel> user = <UserModel>[].obs;

  bool isLoading = false.obs.value;

  Future getUserData() async {
    try {
      isLoading = true;
      http.Response response = await http.get(
        Uri.parse('${BASE_URL}user'),
        headers: {'Accept': 'application/json'},
      );
      if (response.statusCode == 201) {
        isLoading = false;
        final List<dynamic> jsonResponse = convert.jsonDecode(response.body);
        user.value = jsonResponse.map((e) => UserModel.fromJson(e)).toList();
        print(user);
      } else {
        isLoading = false;
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      isLoading = false;
      print(e);
    } finally {
      isLoading = false;
    }
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_course/services/endpoints.dart';

import 'package:get/get.dart';
import 'dart:convert' as convert;
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class FavoriteAndUnfavoritePostController extends GetxController {
  final isLoading = false.obs;
  final token = GetStorage().read('token');

  Future favoriteAndUnfavoritePost(id) async {
    try {
      isLoading(true);
      var response = await http.post(
        Uri.parse('${BASE_URL}feed/like/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 201 ||
          jsonDecode(response.body)['message'] == 'Post liked successfully') {
        isLoading(false);

        snackBarMessage(response);
      } else if (response.statusCode == 201 ||
          jsonDecode(response.body)['message'] == 'Post unliked successfully') {
        isLoading(false);

        snackBarMessage(response);
      } else {
        isLoading(false);
        snackBarMessage(response);
      }
    } catch (e) {
      isLoading(false);
      snackBarMessage(
        http.Response(
          json.encode({
            'message': 'Error occurred',
          }),
          500,
        ),
      );
    } finally {
      isLoading(false);
    }
  }

  // Increase post like count if like
  // Future increaseFavoriteCount
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

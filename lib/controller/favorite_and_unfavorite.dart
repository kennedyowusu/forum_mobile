import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_course/services/endpoints.dart';

import 'package:get/get.dart';
import 'dart:convert' as convert;
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:online_course/widgets/snackbar.dart';

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

        SnackBarMessage(message: '${jsonDecode(response.body)['message']}');
      } else if (response.statusCode == 201 ||
          jsonDecode(response.body)['message'] == 'Post unliked successfully') {
        isLoading(false);

        SnackBarMessage(message: '${jsonDecode(response.body)['message']}');
      } else {
        isLoading(false);
        SnackBarMessage(
          message: '${jsonDecode(response.body)['message']}',
        );
      }
    } catch (e) {
      isLoading(false);
      SnackBarMessage(
        message: 'Error liking post $e',
      );
    } finally {
      isLoading(false);
    }
  }

  // Increase post like count if like
  // Future increaseFavoriteCount
}

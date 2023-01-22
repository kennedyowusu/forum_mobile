import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert' as convert;
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:online_course/services/endpoints.dart';

import '../model/comment.dart';

class CommentController extends GetxController {
  RxList<Comment> comments = <Comment>[].obs;
  final isLoading = false.obs;
  final token = GetStorage().read('token');

  @override
  onInit() {
    super.onInit();
    // fetchComments(
    //   Get.arguments['id'],
    // );
  }

  Future fetchComments(id) async {
    try {
      comments.clear();
      isLoading(true);

      var response = await http.get(Uri.parse('${BASE_URL}feed/comments/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        isLoading(false);

        final List<Comment> comments = [];
        final List<dynamic> data = convert.jsonDecode(response.body)['comments'];
        for (var item in data) {
          comments.add(Comment.fromJson(item));
        }
      } else {
        isLoading(false);
        debugPrint('Error fetching comments');
      }
    } catch (e) {
      isLoading(false);
      debugPrint('Error fetching comments $e');
    } finally {
      isLoading(false);
    }
  }
}

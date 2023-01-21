import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dart:convert' as convert;
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:online_course/model/post.dart';
import 'package:online_course/services/endpoints.dart';

class PostController extends GetxController {
  RxList<Post> posts = <Post>[].obs;
  final isLoading = true.obs;
  final token = GetStorage().read('token');

  @override
  void onClose() {
    fetchPosts();
    super.onClose();
  }

  Future fetchPosts() async {
    try {
      isLoading(true);
      var response = await http.get(Uri.parse('$BASE_URL/feeds'), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        isLoading(false);
        
        final List<Post> posts = [];
        final List<dynamic> data = convert.jsonDecode(response.body)['feeds'];
        for (var item in data) {
          posts.add(Post.fromJson(item));
        }
      } else {
        isLoading(false);
        debugPrint('Error fetching posts');
      }
    } catch (e) {
      isLoading(false);
      debugPrint('Error fetching posts $e');
    } finally {
      isLoading(false);
    }
  }
}

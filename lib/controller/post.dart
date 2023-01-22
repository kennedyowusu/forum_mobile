import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dart:convert' as convert;
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:online_course/model/post.dart';
import 'package:online_course/services/endpoints.dart';
import 'package:online_course/widgets/snackbar.dart';

class PostController extends GetxController {
  RxList<Post> posts = <Post>[].obs;
  final isLoading = false.obs;
  final token = GetStorage().read('token');

  onInit() {
    super.onInit();
    fetchPosts();
  }

  Future fetchPosts() async {
    try {
      posts.clear();

      isLoading(true);
      var response = await http.get(Uri.parse('${BASE_URL}feeds'), headers: {
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

  Future createPost(
      {required String title, required String description}) async {
    try {
      Map<String, String> data = {
        'title': title,
        'description': description,
      };
      isLoading(true);
      var response = await http.post(Uri.parse('${BASE_URL}feed/store'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: convert.jsonEncode(data));
      if (response.statusCode == 201) {
        isLoading(false);
        fetchPosts();
        debugPrint('Post created successfully');
        SnackBarMessage(
          message: '${json.decode(response.body)['message']}',
        );
      } else {
        isLoading(false);
        SnackBarMessage(
          message: '${json.decode(response.body)['message']}',
        );
      }
    } catch (e) {
      isLoading(false);
      debugPrint('Error creating post $e');
    } finally {
      isLoading(false);
    }
  }

  Future deletePost({required int id}) async {
    try {
      isLoading(true);
      var response =
          await http.delete(Uri.parse('${BASE_URL}feed/$id'), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        isLoading(false);
        fetchPosts();
        debugPrint('Post deleted successfully');
        SnackBarMessage(
          message: '${json.decode(response.body)['message']}',
        );
      } else {
        isLoading(false);
        SnackBarMessage(
          message: '${json.decode(response.body)['message']}',
        );
      }
    } catch (e) {
      isLoading(false);
      debugPrint('Error deleting post $e');
    } finally {
      isLoading(false);
    }
  }

  Future updatePost({
    required int id,
    required String title,
    required String description,
  }) async {
    try {
      Map<String, String> data = {
        'title': title,
        'description': description,
      };
      isLoading(true);
      var response = await http.put(Uri.parse('${BASE_URL}feed/$id'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: convert.jsonEncode(data));
      if (response.statusCode == 200) {
        isLoading(false);
        fetchPosts();
        debugPrint('Post updated successfully');
        SnackBarMessage(
          message: '${json.decode(response.body)['message']}',
        );
      } else {
        isLoading(false);
        SnackBarMessage(
          message: '${json.decode(response.body)['message']}',
        );
      }
    } catch (e) {
      isLoading(false);
      debugPrint('Error updating post $e');
    } finally {
      isLoading(false);
    }
  }
}

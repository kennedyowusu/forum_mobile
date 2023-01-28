import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dart:convert' as convert;
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:online_course/model/post.dart';
import 'package:online_course/services/endpoints.dart';

class PostController extends GetxController {
  RxList<Post> posts = <Post>[].obs;
  final isLoading = false.obs;
  final token = GetStorage().read('token');

  @override
  onInit() {
    super.onInit();
    fetchPosts();
  }

  Future fetchPosts() async {
    try {
      posts.clear();

      isLoading(true);
      http.Response response =
          await http.get(Uri.parse('${BASE_URL}feeds'), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        isLoading(false);

        final data = convert.jsonDecode(response.body)['feeds'];
        for (var item in data) {
          posts.add(Post.fromJson(item));
          debugPrint("Title: ${item['title']}");
          debugPrint("Description: ${item['description']}}");
          debugPrint("data $data");
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
      http.Response response =
          await http.post(Uri.parse('${BASE_URL}feed/store'),
              headers: {
                'Accept': 'application/json',
                'Authorization': 'Bearer $token',
              },
              body: convert.jsonEncode(data));
      if (response.statusCode == 201) {
        isLoading(false);
        // fetchPosts();
        debugPrint('Post created successfully');
        snackBarMessage(response);
      } else {
        isLoading(false);
        snackBarMessage(response);
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
      http.Response response =
          await http.delete(Uri.parse('${BASE_URL}feed/$id'), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        isLoading(false);
        fetchPosts();
        debugPrint('Post deleted successfully');
        snackBarMessage(response);
      } else {
        isLoading(false);
        snackBarMessage(response);
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
      http.Response response = await http.put(Uri.parse('${BASE_URL}feed/$id'),
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: convert.jsonEncode(data));
      if (response.statusCode == 200) {
        isLoading(false);
        fetchPosts();
        debugPrint('Post updated successfully');
        snackBarMessage(response);
      } else {
        isLoading(false);
        snackBarMessage(response);
      }
    } catch (e) {
      isLoading(false);
      debugPrint('Error updating post $e');
    } finally {
      isLoading(false);
    }
  }
}

SnackbarController snackBarMessage(http.Response response) {
  return Get.snackbar(
    "",
    '${json.decode(response.body)['message']}',
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.black,
    colorText: Colors.white,
    margin: EdgeInsets.all(20),
    borderRadius: 10,
    isDismissible: true,
  );
}

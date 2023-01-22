import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert' as convert;
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:online_course/services/endpoints.dart';
import 'package:online_course/widgets/snackbar.dart';

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

      var response = await http.get(
        Uri.parse('${BASE_URL}feed/comments/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        isLoading(false);

        final List<Comment> comments = [];
        final List<dynamic> data =
            convert.jsonDecode(response.body)['comments'];
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

  // Create comment for a post
  Future createComment({required String comment, id}) async {
    try {
      Map<String, String> data = {
        'comment': comment,
        'post_id': id,
      };
      isLoading(true);
      var response = await http.post(Uri.parse('${BASE_URL}feed/comment/$id'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: convert.jsonEncode(data));
      if (response.statusCode == 201) {
        isLoading(false);
        fetchComments(Get.arguments['id']);
        debugPrint('Comment created successfully');
        SnackBarMessage(
          message:
              'Comment created successfully ${json.decode(response.body)['message']}',
        );
      } else {
        isLoading(false);
        SnackBarMessage(
          message: '${json.decode(response.body)['message']}',
        );
      }
    } catch (e) {
      isLoading(false);
      debugPrint('Error creating comment $e');
    } finally {
      isLoading(false);
    }
  }

  // Delete comment
  Future deleteComment(id) async {
    try {
      isLoading(true);
      var response = await http.delete(
        Uri.parse('${BASE_URL}feed/comment/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        isLoading(false);
        fetchComments(Get.arguments['id']);
        debugPrint('Comment deleted successfully');
        SnackBarMessage(
          message: 'Comment deleted successfully',
        );
      } else {
        isLoading(false);
        SnackBarMessage(
          message: '${json.decode(response.body)['message']}',
        );
      }
    } catch (e) {
      isLoading(false);
      debugPrint('Error deleting comment $e');
    } finally {
      isLoading(false);
    }
  }

  // Update comment
  Future updateComment({required String comment, id}) async {
    try {
      Map<String, String> data = {
        'comment': comment,
      };
      isLoading(true);
      var response = await http.put(Uri.parse('${BASE_URL}feed/comment/$id'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: convert.jsonEncode(data));
      if (response.statusCode == 200) {
        isLoading(false);
        fetchComments(Get.arguments['id']);
        debugPrint('Comment updated successfully');
        SnackBarMessage(
          message: 'Comment updated successfully',
        );
      } else {
        isLoading(false);
        SnackBarMessage(
          message: '${json.decode(response.body)['message']}',
        );
      }
    } catch (e) {
      isLoading(false);
      debugPrint('Error updating comment $e');
    } finally {
      isLoading(false);
    }
  }
}

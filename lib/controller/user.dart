import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:online_course/model/user.dart';
import 'package:online_course/services/endpoints.dart';

class UserController extends GetxController {
  Rx<UserModel> user = UserModel().obs;

  bool isLoading = false.obs.value;
  final token = GetStorage().read('token');

  @override
  void onInit() {
    getUserData();
    super.onInit();
  }

  Future getUserData() async {
    try {
      isLoading = true;
      http.Response response = await http.get(
        Uri.parse('${BASE_URL}user'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        isLoading = false;
        final jsonResponse = convert.jsonDecode(response.body);
        UserModel userData = UserModel.fromJson(jsonResponse);
        user(userData);
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

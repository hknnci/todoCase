import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserController extends GetxController {
  var isLoading = false.obs;
  var isLoggedIn = false.obs;

  void login(String email, String password) async {
    isLoading(true);
    var response = await http.post(
      Uri.parse('https://reqres.in/api/login'), // Fake API endpoint for login
      body: {
        'email': email,
        'password': password,
      },
    );

    isLoading(false);

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      if (jsonResponse.containsKey('token')) {
        isLoggedIn(true);
      }
    } else {
      isLoggedIn(false);
      Get.snackbar(
        'Error',
        'Login failed. Please check your email and password.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}

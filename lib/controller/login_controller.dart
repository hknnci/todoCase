import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:todo_case/utils/constants.dart';
import 'package:todo_case/utils/model/login.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  //for authentication
  final storage = const FlutterSecureStorage();
  final RxBool isLoggedIn = false.obs;

  final Rx<Login?> user = Rx<Login?>(null);

  RxBool passwordHidden = true.obs;

  @override
  void onInit() {
    super.onInit();
    checkLogin();
  }

  Future<void> checkLogin() async {
    String? token = await storage.read(key: "token");
    isLoggedIn.value = token != null;
    if (isLoggedIn.value) {
      String? userJson = await storage.read(key: "user");
      if (userJson != null) {
        user.value = Login.fromJson(json.decode(userJson));
      }
    }
  }

  Future<void> login(String email, String password) async {
    // Fake API request using reqres.in
    final response = await http.post(Uri.parse("${Constants.baseUrl}/login"), body: {"email": email, "password": password});

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final token = data['token'];
      final userJson = json.encode({"email": email, "password": password});

      await storage.write(key: "token", value: token);
      await storage.write(key: "user", value: userJson);

      isLoggedIn.value = true;
      user.value = Login(email: email, password: password);

      showSnackbar(isSuccess: true);
      Get.offAllNamed('/home');
    } else {
      showSnackbar(isSuccess: false);
    }
  }

  Future<void> logout() async {
    await storage.deleteAll();
    isLoggedIn.value = false;
    user.value = null;
    Get.offAllNamed('/login');
  }

  void showSnackbar({bool isSuccess = false}) {
    Get.snackbar(
      isSuccess ? "Başarılı" : "Başarısız",
      isSuccess ? "Başarılı bir şekilde giriş yapıldı." : "Giriş denemesi başarısız oldu.",
      backgroundColor: isSuccess ? Colors.green : Colors.red,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}

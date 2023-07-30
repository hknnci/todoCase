import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:todo_case/utils/constants.dart';
import 'package:todo_case/utils/model/user.dart';

class UserListController extends GetxController {
  final RxList<User> users = <User>[].obs;
  final RxBool isRefreshing = false.obs;

  @override
  void onInit() {
    super.onInit();
    getUsers(); // we're getting users when opening the app
  }

  Future<void> getUsers() async {
    try {
      isRefreshing.value = true; // refreshing the list process is started.

      final response = await http.get(Uri.parse("${Constants.baseUrl}/users"));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> userList = data['data'];
        users.clear();
        users.addAll(userList.map((userJson) => User.fromJson(userJson)));
      } else {
        throw Exception('Failed to load users');
      }
    } catch (e) {
      throw Exception('Failed to get users: $e');
    } finally {
      isRefreshing.value = false; // refreshing the list process is finished.
    }
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_case/controller/user_list_controller.dart';
import 'package:todo_case/utils/model/user.dart';

class UserListScreen extends GetView<UserListController> {
  const UserListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
          onRefresh: () => controller.getUsers(),
          child: Obx(() {
            final List<User> users = controller.users;
            if (controller.isRefreshing.value) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  return InkWell(
                    onTap: () {}, //for press effect
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(user.avatar),
                      ),
                      title: Text('${user.firstName} ${user.lastName}'),
                      subtitle: Text(user.email),
                    ),
                  );
                },
              );
            }
          })),
    );
  }
}

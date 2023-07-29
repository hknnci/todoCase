import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_case/controller/home_controller.dart';
import 'package:todo_case/controller/login_controller.dart';

class HomeScreen extends GetView<HomeController> {
  HomeScreen({Key? key}) : super(key: key);

  final HomeController homeController = Get.find();
  final LoginController loginController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ana Sayfa'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_rounded),
            tooltip: "Çıkış Yap",
            onPressed: () {
              loginController.logout();
            },
          )
        ],
      ),
      body: const Center(
        child: Text('Devam Edecek'),
      ),
    );
  }
}

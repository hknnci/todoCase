import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_case/controller/home_controller.dart';
import 'package:todo_case/controller/login_controller.dart';
import 'package:todo_case/widgets/screens/user_list_screen.dart';

class HomeScreen extends GetView<HomeController> {
  HomeScreen({Key? key}) : super(key: key);

  final LoginController loginController = Get.find();

  final List<Widget> screens = [
    const UserListScreen(),
    //TodoListScreen(),
  ];

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
      body: Obx(() => screens.elementAt(controller.tabIndex.value)),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.tabIndex.value,
          onTap: (index) => controller.changeTabIndex(index),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Kullanıcı Listesi',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.adjust),
              label: 'Yapılacaklar Listesi',
            ),
          ],
        ),
      ),
    );
  }
}

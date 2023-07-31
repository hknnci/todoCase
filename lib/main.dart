import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_case/controller/home_controller.dart';
import 'package:todo_case/controller/login_controller.dart';
import 'package:todo_case/controller/todo_list_controller.dart';
import 'package:todo_case/controller/user_list_controller.dart';
import 'package:todo_case/widgets/screens/home_screen.dart';
import 'package:todo_case/widgets/screens/login_screen.dart';

Future<void> main() async {
  Get.put(LoginController());
  Get.put(HomeController());
  Get.put(UserListController());
  Get.put(TodoListController());
  LoginController loginController = LoginController();
  await loginController.checkLogin();

  runApp(MyApp(loginController: loginController));
}

class MyApp extends StatelessWidget {
  final LoginController loginController;
  const MyApp({super.key, required this.loginController});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          color: Color(0xFFdbd0b2),
          centerTitle: true,
          titleTextStyle: TextStyle(color: Color(0xFFA67926), fontSize: 20, fontWeight: FontWeight.w500),
          iconTheme: IconThemeData(color: Color(0xFFA67926)),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: const Color(0xFFdbd0b2),
          elevation: 10,
          selectedLabelStyle: const TextStyle(color: Color(0xFFA67926), fontSize: 14.0),
          unselectedLabelStyle: TextStyle(color: Colors.grey[600], fontSize: 12.0),
          selectedItemColor: const Color(0xFFA67926),
          unselectedItemColor: Colors.grey[600],
        ),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: loginController.isLoggedIn.value ? '/home' : '/',
      getPages: [
        GetPage(name: '/', page: () => LoginScreen()),
        GetPage(name: '/home', page: () => HomeScreen()),
      ],
    );
  }
}

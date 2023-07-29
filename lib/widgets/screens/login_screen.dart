import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_case/controller/login_controller.dart';

class LoginScreen extends GetView<LoginController> {
  final GlobalKey<FormState> formKey = GlobalKey();
  final LoginController loginController = Get.find();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFcecfd6),
      body: Center(
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                Text(
                  "Hoş Geldiniz",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 30),
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "E-posta",
                    prefixIcon: const Icon(Icons.person_outline),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  validator: (value) {
                    return (value == null || value.isEmpty) ? 'Lütfen E-posta Adresinizi Girin!' : null;
                  },
                ),
                const SizedBox(height: 10),
                Obx(
                  () => TextFormField(
                    controller: passwordController,
                    obscureText: loginController.passwordHidden.value,
                    keyboardType: TextInputType.visiblePassword,
                    validator: (value) {
                      return (value == null || value.isEmpty) ? 'Lütfen Şifrenizi Girin' : null;
                    },
                    decoration: InputDecoration(
                      labelText: "Şifre",
                      prefixIcon: const Icon(Icons.password_outlined),
                      suffixIcon: IconButton(
                        icon: Icon(
                          loginController.passwordHidden.value ? Icons.visibility : Icons.visibility_off,
                          color: Theme.of(context).primaryColorDark,
                        ),
                        onPressed: () => loginController.passwordHidden.value = !loginController.passwordHidden.value,
                      ),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Column(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      ),
                      onPressed: () async {
                        if (formKey.currentState?.validate() ?? false) {
                          await loginController.login(emailController.text, passwordController.text);
                        }
                      },
                      child: const Text('Giriş Yap'),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

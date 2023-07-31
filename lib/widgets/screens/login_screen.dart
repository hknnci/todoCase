import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_case/controller/login_controller.dart';

class LoginScreen extends GetView<LoginController> {
  final GlobalKey<FormState> formKey = GlobalKey();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  FocusNode emailFN = FocusNode();
  FocusNode passwordFN = FocusNode();

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
            padding: const EdgeInsets.all(30),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Colors.white54,
              ),
              child: Column(
                children: [
                  const Text(
                    "Hoş Geldiniz",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 40,
                    ),
                  ),
                  const SizedBox(height: 40),
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    focusNode: emailFN,
                    onFieldSubmitted: (value) => FocusScope.of(context).requestFocus(passwordFN),
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
                  const SizedBox(height: 20),
                  Obx(
                    () => TextFormField(
                      controller: passwordController,
                      obscureText: controller.passwordHidden.value,
                      focusNode: passwordFN,
                      onFieldSubmitted: (value) async {
                        controller.onPressLogin(
                          emailController.text,
                          passwordController.text,
                          formKeyValidate: formKey.currentState?.validate() ?? false,
                        );
                      },
                      keyboardType: TextInputType.visiblePassword,
                      validator: (value) {
                        return (value == null || value.isEmpty) ? 'Lütfen Şifrenizi Girin' : null;
                      },
                      decoration: InputDecoration(
                        labelText: "Şifre",
                        prefixIcon: const Icon(Icons.password_outlined),
                        suffixIcon: IconButton(
                          icon: Icon(
                            controller.passwordHidden.value ? Icons.visibility : Icons.visibility_off,
                            color: Theme.of(context).primaryColorDark,
                          ),
                          onPressed: () => controller.passwordHidden.value = !controller.passwordHidden.value,
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
                          controller.onPressLogin(
                            emailController.text,
                            passwordController.text,
                            formKeyValidate: formKey.currentState?.validate() ?? false,
                          );
                        },
                        child: const Text('Giriş Yap'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Obx(() {
                    return Visibility(
                      visible: controller.isLoggingIn.value,
                      child: const CircularProgressIndicator(),
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

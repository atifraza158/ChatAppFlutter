import 'package:chat_app/controllers/auth_controller.dart';
import 'package:chat_app/views/Utils/app_button/app_button.dart';
import 'package:chat_app/views/Utils/app_colors.dart';
import 'package:chat_app/views/Utils/app_text/app_text.dart';
import 'package:chat_app/views/Utils/common_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'signup_view.dart';

class LoginView extends StatefulWidget {
  LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final key = GlobalKey<FormState>();
  AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: key,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    title: 'Login',
                    size: 22,
                    fontWeight: FontWeight.w600,
                  ),
                  AppText(title: 'WelCome back!'),
                  SizedBox(height: 20),
                  CommonTextField(
                    controller: emailController,
                    hintText: "abc@example.com",
                    ketboardType: TextInputType.emailAddress,
                    validate: (val) {
                      if (val!.isEmpty) {
                        return "Email is Neccessary";
                      } else {
                        return null;
                      }
                    },
                    obsecureText: false,
                  ),
                  SizedBox(height: 10),
                  CommonTextField(
                    controller: passwordController,
                    hintText: '* * * * * *',
                    validate: (val) {
                      if (val!.isEmpty) {
                        return "Password Field cannot be empty";
                      } else {
                        return null;
                      }
                    },
                    obsecureText: true,
                    maxLines: 1,
                  ),
                  SizedBox(height: 30),
                  Obx(
                    () => AppButton(
                      buttonRadius: BorderRadius.circular(25),
                      buttonName: authController.loader.value
                          ? 'Logging you in...'
                          : 'Login',
                      onTap: () {
                        if (key.currentState!.validate()) {
                          authController.login(
                            emailController.text.toString(),
                            passwordController.text.toString(),
                          );
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppText(title: 'Not a member? '),
                      TextButton(
                        onPressed: () {
                          Get.to(() => SignupView());
                        },
                        child: AppText(
                          title: "Sign-Up",
                          color: AppColors.themeColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

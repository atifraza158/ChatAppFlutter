import 'package:chat_app/controllers/auth_controller.dart';
import 'package:chat_app/views/Utils/app_button/app_button.dart';
import 'package:chat_app/views/Utils/app_colors.dart';
import 'package:chat_app/views/Utils/app_text/app_text.dart';
import 'package:chat_app/views/Utils/common_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupView extends StatefulWidget {
  SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final nameController = TextEditingController();
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
                    title: 'Register Yourself!',
                    size: 22,
                    fontWeight: FontWeight.w600,
                  ),
                  AppText(title: 'WelCome back!'),
                  SizedBox(height: 20),
                  CommonTextField(
                    controller: nameController,
                    hintText: "john Doe",
                    validate: (val) {
                      if (val!.isEmpty) {
                        return "name is Neccessary";
                      } else {
                        return null;
                      }
                    },
                    obsecureText: false,
                  ),
                  SizedBox(height: 10),
                  CommonTextField(
                    ketboardType: TextInputType.emailAddress,
                    controller: emailController,
                    hintText: "abc@example.com",
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
                    obsecureText: false,
                  ),
                  SizedBox(height: 30),
                  Obx(
                    () => AppButton(
                      buttonRadius: BorderRadius.circular(25),
                      buttonName: authController.loader.value
                          ? 'Creating User...'
                          : 'Register',
                      onTap: () {
                        if (key.currentState!.validate()) {
                          authController.registerUser(
                            nameController.text.toString(),
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
                      AppText(title: 'Already a member? '),
                      TextButton(
                        onPressed: () {},
                        child: AppText(
                          title: "Sign-in",
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

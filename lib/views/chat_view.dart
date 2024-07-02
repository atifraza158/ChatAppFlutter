import 'package:chat_app/views/Utils/app_colors.dart';
import 'package:chat_app/views/Utils/app_text/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.themeColor,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
            )),
        title: AppText(
          title: 'Chat View',
          color: Colors.white,
        ),
      ),
    );
  }
}

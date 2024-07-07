import 'package:chat_app/controllers/auth_controller.dart';
import 'package:chat_app/views/Utils/app_colors.dart';
import 'package:chat_app/views/Utils/app_text/app_text.dart';
import 'package:chat_app/views/chat_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class HomeView extends StatefulWidget {
  HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  AuthController authController = Get.put(AuthController());
  User? currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("WeChat"),
        actions: [
          IconButton(
            onPressed: () {
              authController.logout();
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var users = snapshot.data!.docs
                .where((doc) => doc['uid'] != currentUser?.uid)
                .toList();
            return Padding(
              padding: const EdgeInsets.all(12),
              child: SingleChildScrollView(
                child: Column(
                  children: List.generate(users.length, (index) {
                    DocumentSnapshot userData = users[index];
                    return Column(
                      children: [
                        userTile(
                          userData['userName'],
                          () {
                            print(userData['uid']);
                            Get.to(
                              () => ChatView(
                                userName: userData['userName'],
                                receiverID: userData['uid'],
                              ),
                            );
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Divider(
                            thickness: 0,
                            height: 0,
                          ),
                        ),
                      ],
                    );
                  }),
                ),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(
                color: AppColors.themeColor,
              ),
            );
          }
        },
      ),
    );
  }

  Widget userTile(String name, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
            // color: AppColors.themeColor,
            // borderRadius: BorderRadius.circular(8),
            ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: AppColors.themeColor,
            child: Icon(
              Icons.person,
              color: Colors.white,
            ),
          ),
          title: AppText(
            title: name,
            color: Colors.black,
          ),
          subtitle: AppText(
            title: 'last message',
            size: 11,
          ),
        ),
      ),
    );
  }
}

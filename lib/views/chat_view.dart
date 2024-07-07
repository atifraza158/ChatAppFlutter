import 'package:chat_app/controllers/auth_controller.dart';
import 'package:chat_app/controllers/firebase_controller.dart';
import 'package:chat_app/views/Utils/app_colors.dart';
import 'package:chat_app/views/Utils/app_text/app_text.dart';
import 'package:chat_app/views/Utils/common_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:random_string/random_string.dart';

class ChatView extends StatefulWidget {
  ChatView({
    super.key,
    required this.userName,
    required this.receiverID,
  });
  final String userName;
  final String? receiverID;

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final msgController = TextEditingController();
  final key = GlobalKey<FormState>();
  AuthController authController = Get.put(AuthController());
  FirebaseController firebaseController = Get.put(FirebaseController());
  @override
  void initState() {
    authController.getCurrentUser();
    super.initState();
  }

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
          title: '${widget.userName}',
          color: Colors.white,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: StreamBuilder<QuerySnapshot>(
                stream: firebaseController.getMessages(
                  widget.receiverID.toString(),
                ),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return SingleChildScrollView(
                      child: Column(
                        children: List.generate(
                          snapshot.data!.docs.length,
                          (index) {
                            DocumentSnapshot msg = snapshot.data!.docs[index];
                            return messageTile(
                              msg['sms'],
                              msg['senderID'],
                            );
                          },
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
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Form(
              key: key,
              child: Row(
                children: [
                  Expanded(
                    child: CommonTextField(
                        controller: msgController,
                        validate: (val) {
                          if (val!.isEmpty) {
                            return null;
                          } else {
                            return null;
                          }
                        },
                        hintText: 'Message',
                        obsecureText: false),
                  ),
                  SizedBox(width: 10),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.themeColor,
                    ),
                    child: IconButton(
                      onPressed: () {
                        if (key.currentState!.validate()) {
                          String smsID = randomAlphaNumeric(10);
                          Map<String, dynamic> messageData = {
                            'smsID': smsID,
                            'sms': msgController.text.toString(),
                            'sent_at': Timestamp.now(),
                            'senderID': authController.currentUser!.uid,
                            'receiver': widget.receiverID,
                          };

                          firebaseController.addData(
                            "Messages",
                            smsID,
                            messageData,
                          );

                          msgController.clear();
                        }
                      },
                      icon: Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget messageTile(String msg, String senderID) {
    bool isSentByMe = senderID == authController.currentUser!.uid;
    return Row(
      mainAxisAlignment:
          isSentByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Flexible(
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: isSentByMe ? AppColors.themeColor : Colors.grey,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Container(
              padding: EdgeInsets.all(0),
              child: AppText(
                title: msg,
                color: AppColors.whiteColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

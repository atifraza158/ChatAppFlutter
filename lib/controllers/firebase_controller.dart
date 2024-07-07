import 'package:chat_app/controllers/auth_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class FirebaseController extends GetxController {
  RxBool loader = false.obs;
  AuthController authController = Get.put(AuthController());

  addData(
      String collectionName, String docID, Map<String, dynamic> data) async {
    return FirebaseFirestore.instance
        .collection(collectionName)
        .doc(docID)
        .set(data);
  }

  Stream<QuerySnapshot> getMessages(String receiverID) {
    return FirebaseFirestore.instance.collection('Messages').where('receiver',
            whereIn: [receiverID, authController.currentUser!.uid])
        // .orderBy('sent_at', descending: true)
        .snapshots();
  }
}

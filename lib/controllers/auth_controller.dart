import 'package:chat_app/views/home_view.dart';
import 'package:chat_app/views/auth_views/login_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

String? currentUserUid;

class AuthController extends GetxController {
  RxBool loader = false.obs;
  String? currentUserName;

  // Login User
  login(String email, String password) async {
    loader.value = true;
    update();

    await FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((user) {
      currentUserUid = user.user!.uid;
      loader.value = false;
      update();
      Get.offAll(() => HomeView());
      Get.snackbar('Success', "Logged in as ${user.user!.email}");
      return user;
    });
  }

  // Register User
  registerUser(String userName, String email, String password) async {
    loader.value = true;
    update();
    UserCredential userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    FirebaseFirestore.instance
        .collection("Users")
        .doc(userCredential.user!.uid)
        .set({
      'userName': userName,
      'email': email,
      'created_at': Timestamp.now(),
      'uid': userCredential.user!.uid,
    }).then((_) {
      loader.value = false;
      update();
      Get.snackbar("Success", 'User Created Successfully');
      Get.to(() => LoginView());
    });
  }

  // Logout User...
  logout() async {
    await FirebaseAuth.instance.signOut().then((_) {
      Get.offAll(() => LoginView());
      Get.snackbar('Successfully', 'Logged Out');
    });
  }

  
}

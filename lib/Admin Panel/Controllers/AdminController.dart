import 'package:cfoa_fyp/Admin%20Panel/Models/AdminLoginModel.dart';
import 'package:cfoa_fyp/Constant/Constant.dart';
import 'package:cfoa_fyp/Models/AuthenticationModel.dart';
import 'package:cfoa_fyp/Screens/SplashScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';


class AdminController extends GetxController {
  static AdminController instance = Get.find();
  Rx<User> firebaseUser;
  final adminReference = FirebaseFirestore.instance.collection("admins");
  FirebaseAuth auth = FirebaseAuth.instance;
  Rx<AdminAuthentication>  adminAuthentication = AdminAuthentication().obs;
  @override
  void onReady() {
    super.onReady();
    firebaseUser = Rx<User>(auth.currentUser);
    firebaseUser.bindStream(auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User user) {
    if (user == null) {
      return ;
    } else {
      adminAuthentication.bindStream(listenAdmin());
    }
  }



  Stream<AdminAuthentication> listenAdmin() =>
      adminReference.doc(firebaseUser.value.uid)
          .snapshots()
          .map((snapshot) => AdminAuthentication.fromSnapshot(snapshot));
}
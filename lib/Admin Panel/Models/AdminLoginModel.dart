import 'package:cfoa_fyp/Admin%20Panel/Screens/AdminHome.dart';
import 'package:cfoa_fyp/Admin%20Panel/Screens/AdminLoginScreen.dart';
import 'package:cfoa_fyp/Admin%20Panel/Widgets/ShowLoading.dart';
import 'package:cfoa_fyp/Config/Shared_Prefrences.dart';
import 'package:cfoa_fyp/Constant/Constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
class AdminAuthentication {
  static const ID = "uid";
  static const NAME = "name";
  static const EMAIL = "email";
  static const AdminPROFILE = "imageUrl";

  String uid;
  String name;
  String email;
  String adminProfile;
  AdminAuthentication({this.uid,this.name,this.email,this.adminProfile});
  AdminAuthentication.fromSnapshot(DocumentSnapshot snapshot) {
    name = snapshot.data()[NAME];
    email = snapshot.data()[EMAIL];
    uid = snapshot.data()[ID];
    adminProfile = snapshot.data()[AdminPROFILE];
  }




  final  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final adminReference = FirebaseFirestore.instance.collection("admins");


  Future<void> signIn(
      String email,
      String password,
      ) async{
    showLoading();
    User  firebaseUser = (await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password).catchError((e){
          dismissibleLoading();
      authentication.displayToast("Error ${e.toString()}");
    })).user;
    if(firebaseUser != null){
      final dataSnapshot = await adminReference
          .doc(firebaseUser.uid)
          .get();
        if(dataSnapshot.exists){
          await SharedPreferencesData.sharedPreferences.setString(SharedPreferencesData.adminUid, dataSnapshot.data()[SharedPreferencesData.adminUid]);
          await SharedPreferencesData.sharedPreferences.setString(SharedPreferencesData.adminName, dataSnapshot.data()[SharedPreferencesData.adminName]);
          await SharedPreferencesData.sharedPreferences.setString(SharedPreferencesData.adminEmail, dataSnapshot.data()[SharedPreferencesData.adminEmail]);
          await SharedPreferencesData.sharedPreferences.setString(SharedPreferencesData.adminProfile, dataSnapshot.data()[SharedPreferencesData.adminProfile]);
          authentication.displayToast("You are successfully logged In");
          Get.offAll(AdminHome());
        }
        else{
          dismissibleLoading();
          _firebaseAuth.signOut();
          authentication.displayToast("no record has been found");
        }
    }
    else{
      dismissibleLoading();
      authentication.displayToast("Cannot be signed in");
    }
  }
  Future<void> forgetPassword(
      String email,
      BuildContext context
      )async{
    showLoading();
    try{
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      authentication.displayToast("Password reset link send to your email account");
      Get.to(AdminLogin());
    }
    catch(e){
      authentication.displayToast('Error${e.toString()}');
      dismissibleLoading();
    }
  }
  Future<void> changeAdminEmail(String newEmail) async{
    showLoading();
    User user =  _firebaseAuth.currentUser;
    user.updateEmail(newEmail).then((value) {
      updateAdminData({'email':newEmail});
      dismissibleLoading();
      authentication.displayToast("email updated successfully");
      Get.back();
    }).catchError((err){
      dismissibleLoading();
      authentication.displayToast("Error: "+ err.toString());
    });
  }

  Future<void> updateAdminData(Map<String, dynamic> data) async{
    logger.i("UPDATED");
    await adminReference
        .doc(SharedPreferencesData.sharedPreferences.getString(SharedPreferencesData.adminUid))
        .update(data);
  }


}


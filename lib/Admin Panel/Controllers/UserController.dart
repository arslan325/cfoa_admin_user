import 'package:cfoa_fyp/Admin%20Panel/Widgets/ShowLoading.dart';
import 'package:cfoa_fyp/Admin%20Panel/Widgets/ShowToastMessage.dart';
import 'package:cfoa_fyp/Config/Shared_Prefrences.dart';
import 'package:cfoa_fyp/Constant/Constant.dart';
import 'package:cfoa_fyp/Models/AuthenticationModel.dart';
import 'package:cfoa_fyp/Screens/HomeScreen/HomeScreenMain.dart';
import 'package:cfoa_fyp/Screens/Login_Screen.dart';
import 'package:cfoa_fyp/Screens/SplashScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';


class UserController extends GetxController {
  static UserController instance = Get.find();
  Rx<User> firebaseUser;
  RxBool isLoggedIn = false.obs;
  final userReference = FirebaseFirestore.instance.collection("Users");
  final  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  RxList<Authentication> allCustomers = RxList<Authentication>([]);
  Rx<Authentication> authentication = Authentication().obs;
  @override
  void onReady() {
    super.onReady();
    allCustomers.bindStream(getAllCustomers());
    firebaseUser = Rx<User>(auth.currentUser);
    firebaseUser.bindStream(auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User user) {
    if (user == null) {
     // Get.offAll(() => (SplashWelcome()));
      return ;
    } else {
      authentication.bindStream(listenToUser());
    }
  }



  //1: This function is used to create new user in application
  Future<void> registerNewUser(String name , String email , String password) async{
    User  firebaseUser = (await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password).catchError((e){
      dismissibleLoading();
      displayToast("Error ${e.toString()}");
    })).user;
    if(firebaseUser != null){
      userReference.doc(firebaseUser.uid).set({
        "uid": firebaseUser.uid,
        "name": name,
        "email": email,
        "imageUrl" : SharedPreferencesData.sharedPreferences.getString(SharedPreferencesData.imageUrl),
      }).then((value) {
         SharedPreferencesData.sharedPreferences.setString(SharedPreferencesData.userUid, firebaseUser.uid);
         SharedPreferencesData.sharedPreferences.setString(SharedPreferencesData.userName, name);
         SharedPreferencesData.sharedPreferences.setString(SharedPreferencesData.email, firebaseUser.email);
         SharedPreferencesData.sharedPreferences.setString(SharedPreferencesData.userProfile,
          SharedPreferencesData.sharedPreferences.getString(SharedPreferencesData.imageUrl),
        );
         dismissibleLoading();
        displayToast("Congratulation, you are successfully register into the app");
        Get.back();
      });
    }
    else{
      dismissibleLoading();
      displayToast("failed to create new user");
    }
  }

  //2: This function is used to login into application
  Future<void> signIn(String email , String password) async {
    showLoading();
    User firebaseUser = (await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password).catchError((e) {
      dismissibleLoading();
      displayToast("Error ${e.toString()}");
    })).user;
    if (firebaseUser != null) {
      final dataSnapshot = await userReference
          .doc(firebaseUser.uid)
          .get();
      if (dataSnapshot.exists) {
        await SharedPreferencesData.sharedPreferences.setString(
            SharedPreferencesData.userUid,
            dataSnapshot.data()[SharedPreferencesData.userUid]);
        await SharedPreferencesData.sharedPreferences.setString(
            SharedPreferencesData.userName,
            dataSnapshot.data()[SharedPreferencesData.userName]);
        await SharedPreferencesData.sharedPreferences.setString(
            SharedPreferencesData.email,
            dataSnapshot.data()[SharedPreferencesData.email]);
        await SharedPreferencesData.sharedPreferences.setString(
            SharedPreferencesData.userProfile,
            dataSnapshot.data()[SharedPreferencesData.userProfile]);
        displayToast("You are successfully logged In");
        Get.offAll(HomeScreen());
      }
      else {
        dismissibleLoading();
        _firebaseAuth.signOut();
        displayToast("no record has been found for this user. please create new account");
      }
    }
    else {
      dismissibleLoading();
      displayToast("Cannot be signed in");
    }
  }

  //3: This function is used to reset password
  void forgetPassword(String email) async{
    showLoading();
    try{
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      displayToast("Password reset link send to your email account");
      Get.to(LoginScreen());
    }
    catch(e){
      displayToast('Error${e.toString()}');
      dismissibleLoading();
    }
  }

  Future<void> changeEmail(String newEmail) async{
    showLoading();
    User user =  _firebaseAuth.currentUser;
    user.updateEmail(newEmail).then((value) {
      userController.updateUserData({'email':newEmail});
      dismissibleLoading();
      displayToast("email updated successfully");
      Get.back();
    }).catchError((err){
      dismissibleLoading();
      displayToast("Error: "+ err.toString());
    });
  }

  //4: This function is used if user wants to change their password
  Future<void> changePassword(String newPassword) async{
    showLoading();
    User user =  _firebaseAuth.currentUser;
    user.updatePassword(newPassword).then((value) {
      dismissibleLoading();
      displayToast("Your password has been updated successfully");
      Get.back();
    }).catchError((err){
      dismissibleLoading();
      displayToast("Error: "+ err.toString());
    });
  }


  //5: This function is used to logout from app
  void  signOut ()async{
    showLoading();
    await _firebaseAuth.signOut();
    displayToast("You are successfully logout");
    Get.offAll(SplashWelcome());
    dismissibleLoading();
  }


  Stream<List<Authentication>> getAllCustomers() =>
      userReference.snapshots().map((
          query) =>
          query.docs.map((item) => Authentication.fromMap(item.data())).toList());
 Future<void> updateUserData(Map<String, dynamic> data) async{
    logger.i("UPDATED");
   await userReference
        .doc(firebaseUser.value.uid)
        .update(data);
  }


  Stream<Authentication> listenToUser() =>
      userReference.doc(firebaseUser.value.uid)
      .snapshots()
      .map((snapshot) => Authentication.fromSnapshot(snapshot));
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesData{
  static SharedPreferences sharedPreferences;
  static User user;
  static FirebaseAuth auth;
  static FirebaseFirestore firestore;


  static final String userName = 'name';
  static final String email = 'email';
  static final String userProfile = 'imageUrl';
  static final String imageUrl = 'Url';
  static final String userUid ="uid";
  static final String adminName = 'name';
  static final String adminEmail = 'email';
  static final String adminProfile = 'imageUrl';
  static final String adminUid ="uid";
  static final String deviceFCMTargetToken = "Token";


}
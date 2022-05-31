import 'dart:convert';
import 'package:cfoa_fyp/Config/Shared_Prefrences.dart';
import 'package:cfoa_fyp/Constant/Constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import '../../Notification/NotificationModel.dart';
import 'package:http/http.dart' as http;
class NotificationController extends GetxController {
  static NotificationController instance = Get.find();
  final userReference = FirebaseFirestore.instance.collection("Users");
  @override
  onReady() {
    super.onReady();
  }

  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
 RxInt totalNotifications;
  PushNotification notificationInfo;

  Future<void> updateFCMDeviceToken() async{
    var token = await firebaseMessaging.getToken();
    userReference.doc(userController.authentication.value.uid).update({'Token':token});
    firebaseMessaging.subscribeToTopic('allUsers');
  }

  Future<void> getFCMToken(String customerId) async{
    userReference.doc(customerId).get().then((value) {
      SharedPreferencesData.sharedPreferences.setString(SharedPreferencesData.deviceFCMTargetToken, value.data()['Token']);
    }
    );
  }

  static Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    await Firebase.initializeApp();
    print("Handling a background message: ${message.messageId}");
  }
  static Future<void> firebaseMessagingMessageOpenHandler(RemoteMessage message) async {
    await Firebase.initializeApp();
    print("Handling a Open message: ${message.messageId}");
  }
  //
   Future<void> sendNotification(String notificationTitle, String notificationBody, String targetFCMToken) async {
     final String _url = 'https://fcm.googleapis.com/fcm/send';
    Map<String, String> _headers = Map<String, String>();
    _headers['Content-Type'] = 'application/json';
    _headers['Authorization'] = 'key=AAAASUSg9l0:APA91bGNde9ViavcLAdG7CqvxjDxwG5Qzm2guLAjD1X9jSOGAcUbDbfjJMVA_BwCaT3SxcC4dzM4wTWLNkNdI92nsnAWg6BeVflhHjjrZQGI2BTvb8DCTDGPRyEYcyxXj7f-lvyrmscW';

    Map<String, dynamic> _body = Map<String, dynamic>();
    _body['notification'] = {
      'title': notificationTitle,
      'body': notificationBody,
      //'image': imageUrl,
      'sound': 'default'
    };
    _body['priority'] = 'high';
    _body['data'] = {
      'click_action': 'FLUTTER_NOTIFICATION_CLICK',
      'id': '1',
      'status': 'done'
    };
    _body['to'] = targetFCMToken;
    await http.post(Uri.parse(_url), headers: _headers, body: jsonEncode(_body),);

  }
  // void registerNotification() async {
  //   await Firebase.initializeApp();
  //   _messaging = FirebaseMessaging.instance;
  //
  //
  //   NotificationSettings settings = await _messaging.requestPermission(
  //     alert: true,
  //     badge: true,
  //     provisional: false,
  //     sound: true,
  //   );
  //
  //   if (settings.authorizationStatus == AuthorizationStatus.authorized) {
  //     print('User granted permission');
  //
  //     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //       PushNotification notification = PushNotification(
  //         title: message.notification?.title,
  //         body: message.notification?.body,
  //         dataTitle: message.data['title'],
  //         dataBody: message.data['body'],
  //       );
  //         notificationInfo = notification;
  //       totalNotifications++;
  //
  //       if (notificationInfo != null) {
  //         // For displaying the notification as an overlay
  //         showSimpleNotification(
  //           Text(notificationInfo.title),
  //           leading: NotificationBadge(totalNotifications: totalNotifications),
  //           subtitle: Text(notificationInfo.body),
  //           background: Colors.redAccent,
  //           duration: Duration(seconds: 2),
  //         );
  //       }
  //     });
  //   } else {
  //     print('User declined or has not accepted permission');
  //   }
  // }

  // For handling notification when the app is in terminated state
  // checkForInitialMessage() async {
  //   RemoteMessage initialMessage =
  //   await FirebaseMessaging.instance.getInitialMessage();
  //
  //   if (initialMessage != null) {
  //     PushNotification notification = PushNotification(
  //       title: initialMessage.notification?.title,
  //       body: initialMessage.notification?.body,
  //       dataTitle: initialMessage.data['title'],
  //       dataBody: initialMessage.data['body'],
  //     );
  //       notificationInfo = notification;
  //     totalNotifications++;
  //   }
  // }





}
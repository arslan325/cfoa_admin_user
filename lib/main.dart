import 'dart:async';
import 'package:cfoa_fyp/Admin%20Panel/Controllers/AdminController.dart';
import 'package:cfoa_fyp/Admin%20Panel/Controllers/CartController.dart';
import 'package:cfoa_fyp/Admin%20Panel/Controllers/CustomDesignController.dart';
import 'package:cfoa_fyp/Admin%20Panel/Controllers/OrderController.dart';
import 'package:cfoa_fyp/Admin%20Panel/Controllers/UserController.dart';
import 'package:cfoa_fyp/Admin%20Panel/Widgets/ShowAlert.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Admin Panel/Controllers/Category_Controller.dart';
import 'Admin Panel/Controllers/CustomDesignOrderController.dart';
import 'Admin Panel/Controllers/ImagePickerController.dart';
import 'Admin Panel/Controllers/Product_Controller.dart';
import 'Config/Shared_Prefrences.dart';
import 'Admin Panel/Controllers/NotificationController.dart';
import 'Screens/SplashScreen.dart';
import 'package:percent_indicator/percent_indicator.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseMessaging.onBackgroundMessage(NotificationController.firebaseMessagingBackgroundHandler);
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });
  await Firebase.initializeApp().then((value) {
    Get.put(CategoryController());
    Get.put(ProductController());
    Get.put(UserController());
    Get.put(CartController());
    Get.put(OrderController());
    Get.put(CustomDesignController());
    Get.put(CustomDesignOrderController());
    Get.put(NotificationController());
    Get.put(ImagePickerController());
    Get.put(AdminController());
  });
  SharedPreferencesData.sharedPreferences = await SharedPreferences.getInstance();
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => RemoveList()),
        ],
        child:
        MyApp(),

  ));
}
DatabaseReference reference = FirebaseDatabase.instance.reference().child('User');
class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double _progress = 0.0;
  @override
  void initState() {
    startTimer();
    super.initState();
  }

  void startTimer() {
    new Timer.periodic(
      Duration(seconds: 1),
          (Timer timer) => setState(
            () {
          _progress+=10;
        },
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        defaultTransition: Transition.rightToLeft,
        theme: ThemeData(
          fontFamily: 'GoogleFont'
        ),
        debugShowCheckedModeBanner: false,
        title: 'Custom Furniture Ordering App',
        home: AnimatedSplashScreen(
            duration: 3000,
            splash: Container(
              width: 200,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Color(0xff0f2057).withOpacity(.5),
                      blurRadius: 15)
                ],

              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image(
                    image: AssetImage('images/logo.png'),
                    fit: BoxFit.fitWidth,
                  ),
                  SizedBox(height: 10,),
                  new LinearPercentIndicator(
                    animation: true,
                    lineHeight: 15.0,
                    animationDuration: 3000,
                    percent: 1.0,
                    linearStrokeCap: LinearStrokeCap.roundAll,
                    progressColor: Colors.green,
                  ),
                ],
              )

            ),
           nextScreen: SplashWelcome(),
            splashTransition: SplashTransition.fadeTransition,
            splashIconSize: 200,
            backgroundColor: Colors.white,
           pageTransitionType: PageTransitionType.rightToLeft,
        ),
    );
  }
}

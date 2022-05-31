import 'package:cfoa_fyp/Admin%20Panel/Screens/AdminLoginScreen.dart';
import 'package:cfoa_fyp/Constant/Constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Login_Screen.dart';
class SplashWelcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbackgroundColor,
      body: SplashBody(),
    );
  }
}
class SplashBody extends StatefulWidget {
  @override
  _SplashBodyState createState() => _SplashBodyState();
}

class _SplashBodyState extends State<SplashBody> {

  @override
  Widget build(BuildContext context) {
    final width =MediaQuery.of(context).size.width.toInt();
    final height =MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.only(top: 60,left: 10,right: 10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: Text("Welcome",style: kheadingStyle),
            ),
            SizedBox(height: 10),
            Text('To Gujrat Furniture',style: klabelStyle
            ),
            SizedBox(height: height*0.1),
            Container(
              width: width*0.7,
              child: Image(
                image: AssetImage('images/logo.png'),
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: height*0.17,),
            CustomButton(title: 'Are You Admin ?',
              iconData: Icons.arrow_forward_ios,
              clickFuction:
                  (){
                  Get.to(AdminLogin());
              },
            ),
            SizedBox(height: 5),
            Text("OR",style: klabelStyle
              ,),
            SizedBox(height: 5,),
            CustomButton(title: 'Are You Customer ?',
              iconData: Icons.arrow_forward_ios,
              clickFuction: (){
                Get.to(() => LoginScreen());
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String title;
  final IconData iconData;
  final Function clickFuction;
  const CustomButton({this.title,this.iconData,this.clickFuction});
  @override
  Widget build(BuildContext context) {
    final width =MediaQuery.of(context).size.width.toInt();
    return Container(
      height: 50,
      width: width*1.1,
      margin: EdgeInsets.all(25),
      child: FlatButton(
        color: kbuttonColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        onPressed: clickFuction,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(title, style: kbuttonStyle,),
            ),
            SizedBox(width: 15),
            Align(
              alignment: Alignment.centerRight,
              child: Icon(iconData,
                color: kbuttonTextColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
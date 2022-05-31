import 'package:cfoa_fyp/Constant/Constant.dart';
import 'package:cfoa_fyp/Screens/HomeScreen/HomeScreenMain.dart';
import 'package:cfoa_fyp/Widgets/CustomRoundedButton.dart';
import 'package:cfoa_fyp/Widgets/DrawerWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class OrderPlacedSuccessfullyScreen extends StatefulWidget {
  @override
  _OrderPlacedSuccessfullyScreenState createState() =>
      _OrderPlacedSuccessfullyScreenState();
}

class _OrderPlacedSuccessfullyScreenState
    extends State<OrderPlacedSuccessfullyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbackgroundColor,
      // appBar: AppBar(
      //   leading: Builder(
      //     builder: (context) => IconButton(
      //       icon: SvgPicture.asset(
      //         'images/menu.svg',
      //         color: kbuttonColor,
      //         width: 20,
      //       ),
      //       onPressed: () => Scaffold.of(context).openDrawer(),
      //     ),
      //   ),
      //   // title: Text(
      //   //   style: klabelStyle,
      //   // ),
      //   // centerTitle: true,
      //   elevation: 0.5,
      //   backgroundColor: kbackgroundColor,
      // ),
      // drawer: DrawerWidget(),
      body: SafeArea(
        child: Center(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(80),
                      border: Border.all(
                         color: kbuttonColor.withOpacity(0.2),
                        width: 10
                      )
                    ),
                    child: CircleAvatar(
                      radius: 70,
                      backgroundColor: kbuttonColor,
                      child: Icon(Icons.done,
                        color: Colors.white,
                        size: 80,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30,),
                Text("Order Placed!",style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                ),),
                SizedBox(height: 10,),
                Align(
                  alignment: Alignment.center,
                  child: Text("      Your order placed successfully.\n  For more details. check delivery status \n      under menu tab of main screen.",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black.withOpacity(0.5)
                  ),),
                ),
                SizedBox(height: 60,),
                CustomRoundedButton(title: 'Continue Shopping',
                  clickFuction: (){
                  Get.off(HomeScreen());
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

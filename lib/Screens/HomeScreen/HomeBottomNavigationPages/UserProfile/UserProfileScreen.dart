import 'package:cfoa_fyp/Constant/Constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'ChangePasswordScreen.dart';
import 'EditEmailScreen.dart';
import 'EditProfileScreen.dart';
import 'ShippingAddressScreen.dart';

class UserProfileScreen extends StatefulWidget {
  final int index;
  UserProfileScreen({this.index});
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  bool enable = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.index == null){
      enable = true;
    }
    else enable = false;
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: kbackgroundColor,
        appBar: AppBar(
          title: Text(
            "User Profile",
            style: klabelStyle,
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_sharp,
              color: kbuttonColor,
            ),
            onPressed: () {
              Get.back();
            },
          ),
          centerTitle: true,
          elevation: 0.5,
          backgroundColor: kbackgroundColor,
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
          child: Obx(()=>
             SingleChildScrollView(
               child: Center(
                child: Column(
                  children: [
                    SizedBox(height: 30,),
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.white,
                          backgroundImage: NetworkImage(
                              userController.authentication.value.userProfile),
                          child:
                          userController.authentication.value.userProfile ==
                              null
                              ? Icon(
                            Icons.person_rounded,
                            size: 80,
                            color: Colors.black12,
                          )
                              : null,
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: InkWell(
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(80),
                                  border: Border.all(color: Colors.white,
                                    width: 2
                                  )
                              ),
                              child: InkWell(
                                onTap: (){
                                  Get.to(EditProfileScreen());
                                },
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundColor: kbuttonColor,
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      userController.authentication.value.name,
                      style: klabelStyle,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      userController.authentication.value.email,
                      style: TextStyle(
                        color: kbuttonColor,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Divider(thickness: 1,),
                    SizedBox(
                      height: 80,
                    ),
                    Container(
                      height: 60,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(.5), blurRadius: 15)
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ListTile(
                        onTap: (){
                          Get.to(EditEmailAddressScreen());
                        },
                        leading: Icon(Icons.email,color: kbuttonColor,),
                        title: Text('Change Email Address'),
                        trailing: Icon(Icons.arrow_forward_ios,color: kbuttonColor,),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      height: 60,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(.5), blurRadius: 15)
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ListTile(
                        onTap: (){
                          Get.to(ChangePasswordScreen());
                        },
                        leading: Icon(Icons.lock,color: kbuttonColor,),
                        title: Text('Change Password'),
                        trailing: Icon(Icons.arrow_forward_ios,color: kbuttonColor,),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 60,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(.5), blurRadius: 15)
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ListTile(
                        onTap: (){
                          Get.to(ShippingAddressScreen());
                        },
                        leading: Icon(Icons.location_on,color: kbuttonColor,),
                        title: Text('Shipping Address'),
                        trailing: Icon(Icons.arrow_forward_ios,color: kbuttonColor,),
                      ),
                    ),
                  ],
                ),
            ),
             ),
          ),
        ),
      ),
    );
  }
}

import 'package:cfoa_fyp/Admin%20Panel/Screens/AdminForgetPassword.dart';
import 'package:cfoa_fyp/Constant/Constant.dart';
import 'package:cfoa_fyp/Models/AuthenticationModel.dart';
import 'package:cfoa_fyp/Screens/Login_Screen.dart';
import 'package:cfoa_fyp/Widgets/CustomRoundedButton.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class AdminLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbackgroundColor,
      body: AdminLoginScreen(),
    );
  }
}

class AdminLoginScreen extends StatefulWidget {
  @override
  _AdminLoginScreenState createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  TextEditingController _adminEmailTextEditController = new TextEditingController();
  TextEditingController _adminPasswordTextEditController = new TextEditingController();
  Authentication authentication = new Authentication();
  final _formKey = GlobalKey<FormState>();
  final navigatorKey = GlobalKey<NavigatorState>();
  bool obscure = true;

  void visibility(){
    setState(() {
      obscure = !obscure;
    });
  }
  @override
  Widget build(BuildContext context) {
    final width =MediaQuery.of(context).size.width.toInt();
    final height =MediaQuery.of(context).size.height;
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.only(left: 25,right: 25),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: height*0.065,),
              Image(
                image: AssetImage('images/logo.png'),
                width: width*0.7,
                alignment: Alignment.center,
              ),
              SizedBox(height: height*0.045,),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Let's Sign You In As Admin",style: klabelStyle,
                ),
              ),
              SizedBox(height: height*0.010,),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("To Continue First, Verify that its's you",style: klabelStyle,
                ),
              ),
              SizedBox(height: height*0.025,),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _adminEmailTextEditController,
                        keyboardType:TextInputType.emailAddress,
                        validator: (value) {
                          if (value.trim().isEmpty) {
                            return 'Please enter your email';
                          }
                          else if(!EmailValidator.validate(value)){
                            return 'email address is not valid';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            hintText: 'Enter your e-mail',
                            prefixIcon: Icon(Icons.email,color: kbuttonColor,),
                            border: new OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)
                            )
                        ),
                      ),
                      SizedBox(height: height*0.020,),
                      TextFormField(
                        controller: _adminPasswordTextEditController,
                        obscureText: obscure,
                        validator: (value){
                          if(value.trim().isEmpty){
                            return 'Please enter your password';
                          }
                          else if(value.trim().length < 5){
                            return 'password must be at least 5 character';
                          }
                          else{
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                            hintText: 'Enter your password',
                            prefixIcon: Icon(Icons.lock,
                              color: kbuttonColor,),
                            suffixIcon: obscure ? IconButton(
                              icon: Icon(Icons.remove_red_eye,
                                color: kbuttonColor,),
                              onPressed: visibility,
                            ) : IconButton
                              (onPressed: visibility,
                                icon: Icon(Icons.visibility_off,
                                  color: kbuttonColor,
                                )) ,
                            border: new OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)
                            )
                        ),
                      ),
                    ],
                  )),
              SizedBox(height: height*0.015,),
              InkWell(
                onTap: (){
                    Get.to(AdminForgetPassword());
                },
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text("Forgot Password?",style:TextStyle(
                      fontFamily: 'Raleway-Regular',
                      fontSize: 16,
                      color: kbuttonColor
                  )),
                ),
              ),
              SizedBox(height: height*0.020,),
              CustomRoundedButton(title: 'Login',
                clickFuction: (){
                  if(_formKey.currentState.validate()){
                    adminAuthentication.signIn(
                        _adminEmailTextEditController.text.trim(),
                        _adminPasswordTextEditController.text.trim(),
                    ).whenComplete(() {
                      _adminEmailTextEditController.clear();
                      _adminPasswordTextEditController.clear();
                    });
                  }
                },
              ),
              SizedBox(height: height*0.18,),
              Container(
                height: 50,
                decoration:BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.blueAccent,)
                ),
                child: TextButton(
                    onPressed: (){
                      Get.to(LoginScreen());
                    },
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "i 'm not Admin",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.black
                          ),
                        ),
                        SizedBox(width: 10,),
                        Icon(Icons.logout,
                          color: kbuttonColor,
                          size: 20,
                        )
                      ],
                    )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


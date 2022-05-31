import 'dart:io';
import 'package:cfoa_fyp/Admin%20Panel/Widgets/ShowLoading.dart';
import 'package:cfoa_fyp/Models/AuthenticationModel.dart';
import 'package:cfoa_fyp/Widgets/CustomRoundedButton.dart';
import 'package:cfoa_fyp/Widgets/CustomeTextField.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '/Constant/Constant.dart';
class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  void initState() {
    super.initState();
    imagePickerController.disposeImage();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbackgroundColor,
      body: SignUp(),
    );
  }
}
class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailTextEditController =  TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController _nameTextEditController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
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
    return WillPopScope(
      onWillPop:() async{
        imagePickerController.disposeImage();
        return true;
      },
      child: SafeArea(
        child: Obx(()=>
           Container(
            padding: const EdgeInsets.only(left: 25,right: 25),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: height*0.035,),
                  Image(
                    image: AssetImage('images/logo.png'),
                    width: width*0.7,
                    alignment: Alignment.center,
                  ),
                  SizedBox(height: height*0.045,),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Create an Account",style: klabelStyle,
                    ),
                  ),
                  SizedBox(height: height*0.010,),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Enter your valid information",style: klabelStyle,
                    ),
                  ),
                  SizedBox(height: height*0.025,),
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.white,
                        backgroundImage: imagePickerController.imageFile.value==null ? null :
                        FileImage(File(imagePickerController.imageFile.value)),
                        child: imagePickerController.imageFile.value == null
                            ? Icon(Icons.person_rounded,
                          size: 80,
                          color: Colors.black12,
                        )
                            :null,
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: InkWell(
                          onTap:() => imagePickerController.pickImage(),
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: kbuttonColor,
                            child: Icon(Icons.add_a_photo,color: Colors.white,size: 18,),
                          ),
                        ),
                      )
                    ],

                  ),
                  SizedBox(height: height*.025,),
                  Form(
                    key: _formKey,
                      child: Column(
                        children: [
                          CustomTextField(
                            textEditController: _nameTextEditController,
                            hintText: 'Enter your name',
                            prefixIcon: Icons.account_circle_rounded,
                            inputFormatter: FilteringTextInputFormatter.allow(RegExp("[a-z A-Z]")),
                            maxLine: 1,
                            validator: (value){
                              if(value.trim().isEmpty){
                                return 'name is necessary';
                              }
                              else if(value.trim().length < 3){
                                return 'name must be at least 3 character';
                              }
                              else{
                                return null;
                              }
                            },
                          ),
                          SizedBox(height: height*0.020,),
                          CustomTextField(
                            textEditController: emailTextEditController,
                            hintText: 'Enter your e-mail',
                            prefixIcon: Icons.email,
                            keyboardType: TextInputType.emailAddress,
                            maxLine: 1,
                            validator: (value){
                              if(value.trim().isEmpty){
                                return 'email address is necessary';
                              }
                              else if(!EmailValidator.validate(value)){
                                return 'email address is not valid';
                              }
                              else{
                                return null;
                              }
                            },
                          ),
                          SizedBox(height: height*0.020,),
                          CustomTextField(
                            textEditController: password,
                            obscureText: obscure,
                            maxLine: 1,
                            hintText: 'Enter your password',
                            prefixIcon: Icons.lock,
                            suffixIcon: obscure ? IconButton(
                              icon: Icon(Icons.remove_red_eye,
                                color: kbuttonColor,),
                              onPressed: visibility,
                            ) : IconButton
                              (onPressed: visibility,
                                icon: Icon(Icons.visibility_off,
                                  color: kbuttonColor,
                                )) ,
                            validator: (value){
                              if(value.trim().isEmpty){
                                return 'password is necessary';
                              }
                              else if(value.trim().length < 5){
                                return 'password must be at least 5 character';
                              }
                              else{
                                return null;
                              }
                            },
                          ),
                        ],
                      )),
                  SizedBox(height: height*0.020,),
                  CustomRoundedButton(title: 'Sign Up',
                    clickFuction: (){
                    if(imagePickerController.imageFile.value == null){
                      authentication.displayToast("Please select image");
                    }
                    else if(_formKey.currentState.validate()){
                      showLoading();
                      imagePickerController.uploadImageToFirebase('Profile Pictures',_nameTextEditController.text).whenComplete(() {
                        setState(() {
                          userController.registerNewUser(
                            _nameTextEditController.text.trim(),
                            emailTextEditController.text.trim(),
                            password.text.trim(),
                          );
                          _nameTextEditController.clear();
                          emailTextEditController.clear();
                          password.clear();
                          imagePickerController.disposeImage();
                        });
                      });
                    }
                    else{
                      return null;
                    }
                    }
                  ),
                  SizedBox(height: height*0.045,),
                  TextButton(
                    onPressed: (){
                      Navigator.pushNamed(context, '/login');
                    },
                    child:Text.rich(
                        TextSpan(
                            children: <InlineSpan>[
                              TextSpan(
                                text: 'Already have an account? ',
                                style: klabelStyle,
                              ),
                              TextSpan(
                                  text: 'Login',
                                  style: TextStyle(
                                      fontFamily: 'Raleway-Regular',
                                      fontSize: 16,
                                      color: kbuttonColor
                                  )
                              ),
                            ]
                        )
                    ),)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
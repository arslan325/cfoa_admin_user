import 'package:cfoa_fyp/Constant/Constant.dart';
import 'package:cfoa_fyp/Widgets/CustomRoundedButton.dart';
import 'package:cfoa_fyp/Widgets/CustomeTextField.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController _passwordTextEditController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool obscure = true;

  void visibility(){
    setState(() {
      obscure = !obscure;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbackgroundColor,
      appBar: AppBar(
        title: Text(
          "Change Password",
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
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
          child: Column(
            children: [
              SizedBox(height: 30,),
              Form(
                key: _formKey,
                child: CustomTextField(
                  maxLine: 1,
                  textEditController: _passwordTextEditController,
                  obscureText: obscure,
                  suffixIcon: obscure ? IconButton(
                    icon: Icon(Icons.remove_red_eye,
                      color: kbuttonColor,),
                    onPressed: visibility,
                  ) : IconButton
                    (onPressed: visibility,
                      icon: Icon(Icons.visibility_off,
                        color: kbuttonColor,
                      )),
                  hintText: 'Enter your new password',
                  prefixIcon: Icons.lock,
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
              ),
              SizedBox(height: 30,),
              CustomRoundedButton(title: 'Change Password',clickFuction:() {
                if(_formKey.currentState.validate()){
                  userController.changePassword(_passwordTextEditController.text.trim());
                }
              })
            ],
          ),
        ),
      ),
    );
  }
}

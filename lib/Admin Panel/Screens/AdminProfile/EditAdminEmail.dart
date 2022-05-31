import 'package:cfoa_fyp/Config/Shared_Prefrences.dart';
import 'package:cfoa_fyp/Constant/Constant.dart';
import 'package:cfoa_fyp/Widgets/CustomRoundedButton.dart';
import 'package:cfoa_fyp/Widgets/CustomeTextField.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditAdminEmailScreen extends StatefulWidget {
  @override
  _EditAdminEmailScreenState createState() => _EditAdminEmailScreenState();
}

class _EditAdminEmailScreenState extends State<EditAdminEmailScreen> {
  TextEditingController _emailTextEditController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  void initState() {
    super.initState();
    _emailTextEditController.text = adminController.adminAuthentication.value.email;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbackgroundColor,
      appBar: AppBar(
        title: Text(
          "Change Email Address",
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
              SizedBox(height: 40,),
              Form(
                key: _formKey,
                child: CustomTextField(
                  textEditController: _emailTextEditController,
                  hintText: 'Enter your new email',
                  prefixIcon: Icons.email,
                  validator: (value) {
                    if (value.trim().isEmpty) {
                      return 'Please enter your email';
                    }
                    else if(!EmailValidator.validate(value)){
                      return 'email address is not valid';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 30,),
              CustomRoundedButton(title: 'Change Email',clickFuction:() {
                if(_formKey.currentState.validate()){
                  adminAuthentication.changeAdminEmail(_emailTextEditController.text.trim());
                }
              })
            ],
          ),
        ),
      ),
    );
  }
}

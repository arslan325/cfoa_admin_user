import 'package:cfoa_fyp/Models/AuthenticationModel.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import '/Constant/Constant.dart';
import 'package:cfoa_fyp/Widgets/CustomRoundedButton.dart';
class AdminForgetPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbackgroundColor,
      body: AdminForgetPasswordScreen(),
    );
  }
}
class AdminForgetPasswordScreen extends StatefulWidget {
  @override
  _AdminForgetPasswordScreenState createState() => _AdminForgetPasswordScreenState();
}

class _AdminForgetPasswordScreenState extends State<AdminForgetPasswordScreen> {
  TextEditingController adminEmailTextEditController =  TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.only(left: 25, right: 25),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: height * 0.067,
              ),
              Image(
                image: AssetImage('images/logo.png'),
                width: width * 0.7,
                alignment: Alignment.center,
              ),
              SizedBox(
                height: height * 0.045,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Reset Your Password",
                  style: klabelStyle,
                ),
              ),
              SizedBox(
                height: height * 0.010,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "By using your registered email",
                  style: klabelStyle,
                ),
              ),
              SizedBox(
                height: height * 0.035,
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: adminEmailTextEditController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value){
                          if(value.trim().isEmpty){
                            return 'please enter your email';
                          }
                          else if(!EmailValidator.validate(value)){
                            return 'email address is not valid';
                          }
                          else{
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                            hintText: 'Enter your e-mail',
                            prefixIcon: Icon(
                              Icons.email,
                              color: kbuttonColor,
                            ),
                            border: new OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8))),
                      ),
                    ],
                  )),
              SizedBox(
                height: height * 0.025,
              ),
              CustomRoundedButton(
                title: 'Reset Password',
                clickFuction: () {
                  if(_formKey.currentState.validate()){
                    adminAuthentication.forgetPassword(
                      adminEmailTextEditController.text.trim(),
                      context
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:io';
import 'package:cfoa_fyp/Admin%20Panel/Widgets/ShowLoading.dart';
import 'package:cfoa_fyp/Config/Shared_Prefrences.dart';
import 'package:cfoa_fyp/Constant/Constant.dart';
import 'package:cfoa_fyp/Widgets/CustomRoundedButton.dart';
import 'package:cfoa_fyp/Widgets/CustomeTextField.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController _nameTextEditController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  void initState() {
    super.initState();
    _nameTextEditController.text = userController.authentication.value.name;
    imagePickerController.disposeImage();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop:() async{
        imagePickerController.disposeImage();
        return true;
      },
      child: Scaffold(
        backgroundColor: kbackgroundColor,
        appBar: AppBar(
          title: Text(
            "Edit Profile",
            style: klabelStyle,
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_sharp,
              color: kbuttonColor,
            ),
            onPressed: () {
              imagePickerController.disposeImage();
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
                Stack(
                  children: [
                    Obx(()=>
                       CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.white,
                        backgroundImage:imagePickerController.imageFile.value ==null?
                        NetworkImage(
                            userController.authentication.value.userProfile):
                          FileImage(File(imagePickerController.imageFile.value))
                      ),
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
                            onTap: () {
                              imagePickerController.pickImage();
                            } ,
                            child: CircleAvatar(
                              radius: 20,
                              backgroundColor: kbuttonColor,
                              child: Icon(
                                Icons.add_a_photo,
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
                SizedBox(height: 30,),
                Form(
                  key: _formKey,
                  child: CustomTextField(
                    textEditController: _nameTextEditController,
                    hintText: 'Enter your new name',
                    prefixIcon: Icons.person_rounded,
                    validator: (value){
                      if(value.trim().isEmpty){
                        return 'please enter your name';
                      }
                      else{
                        return null;
                      }
                    },
                  ),
                ),
                SizedBox(height: 30,),
                CustomRoundedButton(title: 'Save',clickFuction:() {
                  if(_formKey.currentState.validate()){
                    showLoading();
                    imagePickerController.uploadImageToFirebase('Profile Pictures',_nameTextEditController.text).whenComplete(() {
                      if(imagePickerController.imageFile.value == null){
                        userController.updateUserData({
                          'imageUrl':userController.authentication.value.userProfile,
                          'name':_nameTextEditController.text.trim()
                        });
                      }
                      else{
                        userController.updateUserData({
                          'imageUrl':SharedPreferencesData.sharedPreferences.getString(SharedPreferencesData.imageUrl),
                          'name':_nameTextEditController.text.trim()
                        });
                      }
                      dismissibleLoading();
                      Get.back();
                    });
                  }
                  })
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'dart:io';

import 'package:cfoa_fyp/Admin%20Panel/Widgets/ShowLoading.dart';
import 'package:cfoa_fyp/Config/Shared_Prefrences.dart';
import 'package:cfoa_fyp/Constant/Constant.dart';
import 'package:cfoa_fyp/Models/CustomDesignModel.dart';
import 'package:cfoa_fyp/Widgets/CustomRoundedButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CustomDesignUpdateScreen extends StatefulWidget {
 final CustomDesignModel customDesignModel;
  const CustomDesignUpdateScreen({this.customDesignModel});
  @override
  _CustomDesignUpdateScreenState createState() => _CustomDesignUpdateScreenState();
}

class _CustomDesignUpdateScreenState extends State<CustomDesignUpdateScreen> {
  TextEditingController _customDesignTitleTextEditController = new TextEditingController();
  TextEditingController _customDesignDescriptionTextEditController = new TextEditingController();
  void initState() {
    super.initState();
    imagePickerController.disposeImage();
    _customDesignTitleTextEditController.text = widget.customDesignModel.designTitle;
    _customDesignDescriptionTextEditController.text = widget.customDesignModel.designDescription;
  }
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
   final width =MediaQuery.of(context).size.width.toInt();
    final height =MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop:() async{
        imagePickerController.disposeImage();
        return true;
      },
      child: Obx(()=>
         Scaffold(
          backgroundColor: kbackgroundColor,
          appBar: AppBar(
            backgroundColor: kbackgroundColor,
            elevation: 0.5,
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
            title: Text(
              "Update Custom Design",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black),
            ),
            centerTitle: true,
          ),
          body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: height*0.010,),
                  InkWell(
                    onTap: (){
                      imagePickerController.pickImage();
                    },
                    child: Container(
                      height: height*.27,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12)
                      ),
                      child: imagePickerController.imageFile.value == null ? Image.network(widget.customDesignModel.designImage) :
                      Image(
                        image: FileImage(File(imagePickerController.imageFile.value)),
                      ),
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        SizedBox(height: height*0.050,),
                        Form(
                            key: _formKey,
                            child:Column(
                              children: [
                                TextFormField(
                                  controller: _customDesignTitleTextEditController,
                                  validator: (value) {
                                    if (value.trim().isEmpty) {
                                      return 'please fill up title field';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      hintText: 'Enter Design Title*',
                                      border: new OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8)
                                      )
                                  ),
                                ),
                                SizedBox(height: height*0.030,),
                                TextFormField(
                                  controller: _customDesignDescriptionTextEditController,
                                  maxLength: 500,
                                  minLines: 1,
                                  maxLines: 10,
                                  validator: (value) {
                                    if (value.trim().isEmpty) {
                                      return 'please fill up decription field';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      hintText: 'Enter Design short description*',
                                      border: new OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8)
                                      )
                                  ),
                                ),
                              ],
                            )
                        ),
                        SizedBox(height: height*0.040,),
                        CustomRoundedButton(title: 'Update Design',
                          clickFuction: (){
                            if(imagePickerController.imageFile.value == null && _formKey.currentState.validate())
                              {
                                customDesignController.updateCustomDesign(
                                  widget.customDesignModel.designId,
                                  _customDesignTitleTextEditController.text.trim(),
                                    widget.customDesignModel.designImage,
                                  _customDesignDescriptionTextEditController.text.trim(),
                                );
                              }
                            else if(_formKey.currentState.validate())
                              {
                                showLoading();
                                imagePickerController.uploadImageToFirebase('Custom Design Image',_customDesignTitleTextEditController.text.trim(),).whenComplete(() => {
                                  customDesignController.updateCustomDesign(
                                    widget.customDesignModel.designId,
                                    _customDesignTitleTextEditController.text.trim(),
                                    SharedPreferencesData.sharedPreferences.getString(SharedPreferencesData.imageUrl),
                                    _customDesignDescriptionTextEditController.text.trim(),
                                  ),
                                  dismissibleLoading(),
                                });
                              }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

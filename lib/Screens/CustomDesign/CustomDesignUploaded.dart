import 'dart:io';
import 'package:cfoa_fyp/Admin%20Panel/Widgets/ShowLoading.dart';
import 'package:cfoa_fyp/Config/Shared_Prefrences.dart';
import 'package:cfoa_fyp/Constant/Constant.dart';
import 'package:cfoa_fyp/Models/CustomDesignModel.dart';
import 'package:cfoa_fyp/Widgets/CustomRoundedButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
class CustomOrderUploadedScreen extends StatefulWidget {
  @override
  _CustomOrderUploadedScreenState createState() => _CustomOrderUploadedScreenState();
}
class _CustomOrderUploadedScreenState extends State<CustomOrderUploadedScreen> {
  TextEditingController _customDesignTitleTextEditController = new TextEditingController();
  TextEditingController _customDesignDescriptionTextEditController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    imagePickerController.disposeImage();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final width =MediaQuery.of(context).size.width.toInt();
    final height =MediaQuery.of(context).size.height;
    return WillPopScope(
        onWillPop:() async {
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
              "Add New Design",
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
                      child: imagePickerController.imageFile.value == null ? Icon(
                        Icons.add_a_photo,
                        size: 100,
                        color: kbuttonColor,
                      ) : Image(
                        image: FileImage(File(imagePickerController.imageFile.value)),
                        fit: BoxFit.fitHeight,
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
                        CustomRoundedButton(title: 'Add Design',
                          clickFuction: (){
                            if(imagePickerController.imageFile.value == null){
                              authentication.displayToast('Please select image from gallery');
                            }
                            else if(_formKey.currentState.validate()){
                              showLoading();
                              imagePickerController.uploadImageToFirebase('Custom Design Image',_customDesignTitleTextEditController.text.trim()).whenComplete(() {
                                setState(() {
                                  customDesignController.addCustomDesign(
                                    DateTime.now().millisecondsSinceEpoch.toString(),
                                    _customDesignTitleTextEditController.text.trim(),
                                    SharedPreferencesData.sharedPreferences.getString(SharedPreferencesData.imageUrl),
                                    _customDesignDescriptionTextEditController.text.trim(),
                                  );
                                  _customDesignTitleTextEditController.clear();
                                  _customDesignDescriptionTextEditController.clear();
                                  imagePickerController.disposeImage();
                                  dismissibleLoading();
                                });
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

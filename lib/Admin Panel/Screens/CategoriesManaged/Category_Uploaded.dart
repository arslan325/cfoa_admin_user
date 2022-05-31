import 'dart:io';
import 'package:cfoa_fyp/Admin%20Panel/Widgets/ShowLoading.dart';
import 'package:cfoa_fyp/Config/Shared_Prefrences.dart';
import 'package:cfoa_fyp/Constant/Constant.dart';
import 'package:cfoa_fyp/Widgets/CustomRoundedButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
class UploadedCategoryScreen extends StatefulWidget {
  @override
  _UploadedCategoryScreenState createState() => _UploadedCategoryScreenState();
}
class _UploadedCategoryScreenState extends State<UploadedCategoryScreen> {
  TextEditingController _categoryTitleTextEditController = new TextEditingController();
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
              "Add New Category",
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
                  SizedBox(height: height*0.020,),
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
                            child:
                                TextFormField(
                                  controller: _categoryTitleTextEditController,
                                  validator: (value) {
                                    if (value.trim().isEmpty) {
                                      return 'Please enter category title';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      hintText: 'Categry Title*',
                                      border: new OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8)
                                      )
                                  ),
                                ),
                            ),
                        SizedBox(height: height*0.040,),
                        CustomRoundedButton(title: 'Add Category',
                          clickFuction: (){
                          if(imagePickerController.imageFile.value == null){
                            authentication.displayToast('Please select image from gallery');
                          }
                            else if(_formKey.currentState.validate()){
                            showLoading();
                            imagePickerController.uploadImageToFirebase('Category Image' , _categoryTitleTextEditController.text).whenComplete(() {
                              setState(() {
                                categoryController.addCategory(
                                  DateTime.now().millisecondsSinceEpoch.toString(),
                                  _categoryTitleTextEditController.text,
                                  SharedPreferencesData.sharedPreferences.getString(SharedPreferencesData.imageUrl),
                                );
                                _categoryTitleTextEditController.clear();
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

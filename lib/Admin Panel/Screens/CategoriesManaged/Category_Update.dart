import 'dart:io';
import 'package:cfoa_fyp/Admin%20Panel/Widgets/ShowLoading.dart';
import 'package:cfoa_fyp/Config/Shared_Prefrences.dart';
import 'package:cfoa_fyp/Constant/Constant.dart';
import 'package:cfoa_fyp/Models/CategoryModel.dart';
import 'package:cfoa_fyp/Widgets/CustomRoundedButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UpdatedCategoryScreen extends StatefulWidget {
  final CategoryModel category;
  const UpdatedCategoryScreen({this.category});
  @override
  _UpdatedCategoryScreenState createState() => _UpdatedCategoryScreenState();
}

class _UpdatedCategoryScreenState extends State<UpdatedCategoryScreen> {
  TextEditingController _categoryTitleTextEditController = new TextEditingController();
  @override
  void initState() {
    super.initState();
    imagePickerController.disposeImage();
  _categoryTitleTextEditController.text = widget.category.cateTitle;
  }
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    print(widget.category.cateTitle);
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
              "Update Category",
              style: TextStyle(
                  fontFamily: 'Raleway-Bold',
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
                      padding: EdgeInsets.all(10),
                      height: height*.27,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12)
                      ),
                      child: imagePickerController.imageFile.value == null ? Image.network(widget.category.cateImg) :
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
                        CustomRoundedButton(title: 'Update Category',
                          clickFuction: (){
                            if(imagePickerController.imageFile.value == null && _formKey.currentState.validate()){
                              categoryController.updateCategory(
                                  widget.category.categoryId ,
                                  _categoryTitleTextEditController.text,
                                widget.category.cateImg,
                                widget.category.cateTitle
                              ).whenComplete(() {
                                setState(() {
                                  _categoryTitleTextEditController.clear();
                                  imagePickerController.disposeImage();
                                });
                              });
                            }
                            else if(_formKey.currentState.validate()){
                              showLoading();
                              imagePickerController.uploadImageToFirebase('Category Images' , _categoryTitleTextEditController.text).whenComplete(() {
                                setState(() {
                                  categoryController.updateCategory(
                                    widget.category.categoryId ,
                                    _categoryTitleTextEditController.text,
                                      SharedPreferencesData.sharedPreferences.getString(SharedPreferencesData.imageUrl),
                                      widget.category.cateTitle
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